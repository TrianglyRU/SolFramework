/// @function scr_player_dash
function scr_player_dash()
{
	gml_pragma("forceinline");
	
	if (!global.dash || vd_player_type != PLAYER.SONIC || player_index > 0 && cpu_timer_input == 0)
	{
	    exit;
	}
	
	if (action != ACTION.DASH)
	{    
	    if (action == ACTION.NONE && animation == ANIM.LOOKUP && input_down.up && input_press.action_any)
	    {
	        animation = ANIM.MOVE;
	        action = ACTION.DASH;
	        dash_charge = 0;
	        dash_vel = 0;
			
	        audio_play_sfx(snd_charge2, [1.00, 2.30]);
	    }
	    else
	    {
	        return false;    
	    }
	}
	
	var _launch_speed = (item_speed_timer > 0 || super_timer > 0) ? acc_top * 1.5 : acc_top * 2;

	if (input_down.up)
	{
	    if (dash_charge < PARAM_DASH_CHARGE)
	    {
	        dash_charge++;
	    }
		
	    dash_vel = clamp(dash_vel + 0.390625 * facing, -_launch_speed, _launch_speed);
	    spd_ground = dash_vel;
		
	    return false;
	}
	
	if (dash_charge == PARAM_DASH_CHARGE)
	{
		action = ACTION.NONE;
		
	    set_camera_delay(16);
		set_velocity();
		audio_stop_sound(snd_charge2);
	    audio_play_sfx(snd_release2);
		
		// Exit the player control routine
	    return true;
	}
	
	action = ACTION.NONE;
	spd_ground = 0;
	
	audio_stop_sound(snd_charge2);
	return false;
}