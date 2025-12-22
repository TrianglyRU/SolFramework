/// @self obj_player
function scr_player_dash()
{
	if !global.dash || player_type != PLAYER.SONIC || player_index > 0 && cpu_control_timer == 0
	{
	    return;
	}
	
	if action != ACTION.DASH
	{    
	    if action == ACTION.NONE && animation == ANIM.LOOKUP && input_down.up && input_press_action_any()
	    {
	        animation = ANIM.MOVE;
	        action = ACTION.DASH;
	        dash_vel = 0;
			
			// TODO: enable in LTS'25
	        // audio_play_sfx(snd_charge_dash, [1.00, 2.30]);
			
			// TODO: remove in LTS'25
	        audio_play_sfx(snd_charge_dash_no_loop);
	    }
	    else
	    {
	        return false;    
	    }
	}
	
	var _increment_value = 0.390625;
	var _min_speed = _increment_value * 30;
	var _speed_cap = item_speed_timer > 0 || super_timer > 0 ? acc_top * 1.5 : acc_top * 2;

	if input_down.up
	{
	    dash_vel = min(dash_vel + _increment_value, _speed_cap);
	    spd_ground = dash_vel * facing;
		
	    return false;
	}
	
	if abs(spd_ground) >= min(_min_speed, _speed_cap)
	{
		action = ACTION.NONE;
		
		// There is no camera delay for Dash in CD, so we assume it uses the same logic as the Spin Dash camera delay
		var _raw_camera_delay = -((abs(spd_ground) - _min_speed) * 2) + 32;
		
		// TODO: LTS'25
		// audio_stop_sound(snd_charge_dash);
		audio_stop_sound(snd_charge_dash_no_loop);
		audio_play_sfx(snd_release_dash);
		
	    set_camera_delay(floor(_raw_camera_delay * 0.5));
		set_velocity();
		
		// Exit the player control routine
	    return true;
	}
	
	action = ACTION.NONE;
	spd_ground = 0;
	
	audio_stop_sound(snd_charge_dash);
	audio_stop_sound(snd_charge_dash_no_loop);
	
	return false;
}