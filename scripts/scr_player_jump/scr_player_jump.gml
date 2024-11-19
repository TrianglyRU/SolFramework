/// @function scr_player_jump()
/// @self obj_player
function scr_player_jump()
{
	gml_pragma("forceinline");
	
	if (!is_jumping)
	{
		return;
	}

	if (!input_down.action_any)
	{
		vel_y = max(vel_y, jump_min_vel);
	}

	if (vel_y < jump_min_vel || player_index > 0 && cpu_timer_input == 0)
	{
		return;
	}
	
	if (input_press.action3 && super_timer == 0 && global.player_rings >= 50 && global.emerald_count == 7)
	{
		reset_substate();
		audio_play_sfx(snd_transform);
		audio_play_bgm(snd_bgm_super);
		
		state = PLAYERSTATE.LOCKED;
		animation = ANIM.TRANSFORM;
		action = ACTION.TRANSFORM;
		inv_frames = 0;
		item_inv_timer = 0;
		super_timer = 1;
		transform_timer = global.player_physics >= PHYSICS.S3 ? 26 : 36;
		image_alpha = 1.0;
		
		return true;
	}

	switch (vd_player_type)
	{
		case PLAYER.SONIC:
			
			if (global.drop_dash && action == ACTION.NONE && shield_state == SHIELDSTATE.NONE && !input_down.action_any)
			{
				if (shield <= SHIELD.NORMAL || super_timer > 0 || item_inv_timer > 0)
				{
					action = ACTION.DROPDASH;
					dropdash_charge = 0;
				}
			}
			
			if (!input_press.action_any || shield_state != SHIELDSTATE.NONE || super_timer > 0 || item_inv_timer > 0)
			{
				break;
			}

			shield_state = SHIELDSTATE.ACTIVE;
			air_lock_flag = false;
			
			switch (shield)
			{
				case SHIELD.NONE:
				
					if (!global.double_spin)
					{
						break;
					}

					with (obj_double_spin)
					{
						if (vd_target_player == other.id)
						{
							instance_destroy();
						}
					}
					
					shield_state = SHIELDSTATE.DOUBLESPIN;
					
					instance_create(0, 0, obj_double_spin, { vd_target_player: id });
					audio_play_sfx(snd_double_spin);
					
				break;

				case SHIELD.BUBBLE:
				
					vel_x = 0;
					vel_y = 8;
					
					with (obj_shield)
					{
						if (vd_target_player == other.id)
						{
							obj_set_anim(spr_shield_bubble_drop, 6, [0, 1, 1, 1], function(){ set_bubble_shield_animation(); });
						}
					}
					
					audio_play_sfx(snd_shield_bubble2);
					
				break;

				case SHIELD.FIRE:
				
					set_camera_delay(16);
					
					air_lock_flag = true;
					vel_x = 8 * facing;
					vel_y = 0;
					
					with (obj_shield)
					{
						if (vd_target_player == other.id)
						{
							var _dash_sprite = spr_shield_fire_dash;
							
							if (sprite_index != _dash_sprite)
							{
								obj_set_anim(_dash_sprite, 2, [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3], function(){ clear_fire_shield_dash(); });
							}
							else
							{
								obj_restart_anim();
							}
							
							obj_set_priority(1);
						}
					}
					
					audio_play_sfx(snd_shield_fire2);
					
				break;

				case SHIELD.LIGHTNING:
				
					shield_state = SHIELDSTATE.DISABLED;
					vel_y = -5.5;
					
					for (var _i = 0; _i < 4; _i++)
					{
						instance_create(x, y, obj_shield_sparkle, { vd_sparkle_id: _i });
					}
					
					audio_play_sfx(snd_shield_lightning2);
					
				break;
			}
			
		break;
		
		case PLAYER.TAILS:
		
			if (action != ACTION.NONE || !input_press.action_any)
			{
				break;
			}
			
			grv = PARAM_GRV_TAILS_DOWN;
			carry_target = noone;
			air_lock_flag = false;
			is_jumping = false;
			action = ACTION.FLIGHT;
			flight_timer = 480;
			ascend_timer = 0;
			radius_x = radius_x_normal;
			radius_y = radius_y_normal;
			input_down.action_any = false;
			input_press.action_any = false;
			
		break;
		
		case PLAYER.KNUCKLES:
		
			if (action != ACTION.NONE || !input_press.action_any)
			{
				break;
			}
			
			animation = ANIM.GLIDE_AIR;	
			action = ACTION.GLIDE;
			action_state = GLIDESTATE.AIR;
			air_lock_flag = false;
			is_jumping = false;
			spd_ground = 4;
			glide_value = 0;
			glide_angle = facing == DIRECTION.NEGATIVE ? 0 : 180;
			radius_x = 10;
			radius_y = 10;
			vel_x = 0;
			vel_y = max(0, vel_y + 2);
			
		break;
		
		case PLAYER.AMY:
		
			if (action != ACTION.NONE || !input_press.action_any)
			{
				break;
			}
			
			if (!global.roll_lock)
			{
				air_lock_flag = false;
			}
			
			action = ACTION.HAMMERSPIN;
			dropdash_charge = 0;
			
			audio_play_sfx(snd_hammer);
			
		break;
	}
	
	return false;
}