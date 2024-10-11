/// @function scr_player_spindash()
/// @self obj_player
function scr_player_spindash()
{
	gml_pragma("forceinline");
	
	if (!global.spin_dash)
	{
		exit;
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
			audio_play_sfx(snd_charge);
		}
		
		return false;
	}

	if (input_down.down)
	{
		if (!input_press.action_any)
		{
			spindash_charge -= floor(spindash_charge / 0.125) / 256;
			return false;
		}
	
		spindash_charge = min(spindash_charge + 2, 8);
	
		if (audio_is_playing(snd_charge) && spindash_charge > 0)
		{
			spindash_pitch = min(spindash_pitch + 0.1, 1.5);
		}
		else
		{
			spindash_pitch = 1;
		}
	
		var _sound = audio_play_sfx(snd_charge);
		
		audio_sound_pitch(_sound, spindash_pitch);
		obj_restart_anim();
		
		return false;
	}
	
	set_camera_delay(16);
	
	var _base_speed = super_timer > 0 ? 11 : 8;
	
	y += radius_y - radius_y_spin;	
	radius_x = radius_x_spin;
	radius_y = radius_y_spin;
	animation = ANIM.SPIN;
	action = ACTION.NONE;
	spd_ground = (_base_speed + round(spindash_charge) / 2) * facing;
	
	set_velocity();
	audio_stop_sound(snd_charge);
	audio_play_sfx(snd_release);
	
	// Exit the player control routine
	return true;
}