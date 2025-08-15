/// @self obj_player
/// @function scr_player_spindash()
function scr_player_spindash()
{
	gml_pragma("forceinline");
	
	if (!global.spin_dash)
	{
		return;
	}

	if (action != ACTION.SPINDASH)
	{
		if (action == ACTION.NONE && (animation == ANIM.DUCK || animation == ANIM.GLIDE_LAND))
		{
			if (!input_press.action_any || !input_down.down)
			{
				return false;
			}
		
			animation = ANIM.SPINDASH;
			action = ACTION.SPINDASH;
			spindash_charge = 0;
			spindash_pitch = 1;
			vel_x = 0;
			vel_y = 0;
			
			instance_create(0, 0, obj_dust_spindash, { vd_target_player: id });
			audio_play_sfx(snd_charge_spin);
		}
		
		return false;
	}
	
	if (input_down.down)
	{
		if (spindash_charge > 0)
		{
			spindash_charge -= floor(spindash_charge / 0.125) / 256;
		}
		
		if (input_press.action_any)
		{
			spindash_charge = min(spindash_charge + 2, 8);
			if (spindash_charge > 0 && audio_is_playing(snd_charge_spin))
			{
				spindash_pitch = min(spindash_pitch + 0.1, 1.5);
			}
			else
			{
				spindash_pitch = 1;
			}
			
			var _sound = audio_play_sfx(snd_charge_spin);
			
			audio_sound_pitch(_sound, spindash_pitch);
			obj_restart_anim();		
		}
		
		return false;
	}
	
	var _min_speed = 8;
	var _speed = (super_timer > 0 ? 11 : _min_speed) + round(spindash_charge) * 0.5;
	var _raw_camera_delay = -((_speed - _min_speed) * 2) + 32;
	
	y += radius_y - radius_y_spin;	
	radius_x = radius_x_spin;
	radius_y = radius_y_spin;
	animation = ANIM.SPIN;
	action = ACTION.NONE;
	spd_ground = _speed * facing;
	
	set_camera_delay(floor(_raw_camera_delay * 0.5));
	set_velocity();
	audio_stop_sound(snd_charge_spin);
	audio_play_sfx(snd_release);
	
	// Exit the player control routine
	return true;
}