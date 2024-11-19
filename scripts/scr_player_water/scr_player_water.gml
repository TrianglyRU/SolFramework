/// @function scr_player_water()
/// @self obj_player
function scr_player_water()
{
	gml_pragma("forceinline");
	
	/// @method _spawn_splash()
	var _spawn_splash = function()
	{
		if (vel_y == 0)
		{
			return;
		}
		
		if (cpu_state == CPUSTATE.RESPAWN || action == ACTION.CLIMB || action == ACTION.GLIDE && action_state != GLIDESTATE.FALL)
		{
			return;
		}
		
		instance_create(x, obj_rm_stage.water_level, obj_water_splash);
		audio_play_sfx(snd_splash);
	}

	/// @method _set_gravity()
	var _set_gravity = function()
	{
		if (action != ACTION.FLIGHT && (action != ACTION.GLIDE || action_state == GLIDESTATE.FALL))
		{
			reset_gravity();
		}
	}
	
	if (!instance_exists(obj_rm_stage) || !obj_rm_stage.water_enabled || state == PLAYERSTATE.DEATH)
	{
		return;
	}

	if (!is_underwater)
	{
		if (floor(y) < obj_rm_stage.water_level)
		{
			return;
		}
	
		is_underwater = true;
		air_timer = AIR_TIMER_DEFAULT;
		vel_x *= 0.5;
		vel_y *= 0.25;
		
		_set_gravity();
		_spawn_splash();
		
		instance_create(0, 0, obj_bubbles_player, { vd_target_player: id });
		
		if (shield == SHIELD.FIRE || shield == SHIELD.LIGHTNING)
		{
			if (shield == SHIELD.LIGHTNING)
			{
				instance_create(x, y, obj_water_flash);
			}
			else if (shield == SHIELD.FIRE)
			{
				instance_create(x, obj_rm_stage.water_level, obj_explosion_dust, { vd_make_sound: false });
			}
			
			shield = SHIELD.NONE;		
		}
	}

	if (shield != SHIELD.BUBBLE)
	{
		if (air_timer > 0)
		{
			air_timer--;
		}
	
		switch (air_timer)
		{
			case 1500: 
			case 1200:
			case 900:
			
				if (player_index == 0)
				{
					audio_play_sfx(snd_alert);
				}
				
			break;
			
			case 720:
			
				if (player_index == 0)
				{
					audio_play_bgm(snd_bgm_drowning);
				}
				
			break;
			
			case 0:
			
				audio_play_sfx(snd_drown);
				reset_substate();
				
				depth = RENDERER_DEPTH_HIGHEST + player_index;
				grv = PARAM_GRV_UNDERWATER;
				state = PLAYERSTATE.DEATH;
				animation = ANIM.DROWN;
				vel_x = 0;
				vel_y = 0;
				spd_ground = 0;
				
				if (player_index == camera_data.index)
				{
					camera_data.allow_movement = false;
				}
				
				return;
		}
	}
	
	if (floor(y) >= obj_rm_stage.water_level)
	{
		return;
	}

	is_underwater = false;
	
	_set_gravity();
	_spawn_splash();

	if (action == ACTION.FLIGHT)
	{
		audio_play_sfx(snd_flight);
	}

	if (player_index == 0 && audio_is_playing(snd_bgm_drowning))
	{
		audio_reset_bgm(obj_rm_stage.bgm_track, id);
	}

	if (global.player_physics <= PHYSICS.S2 || vel_y >= -4)
	{
		vel_y *= 2;
	}
	
	vel_y = max(-16, vel_y);
}