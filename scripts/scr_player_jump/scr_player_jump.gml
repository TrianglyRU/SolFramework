/// @self obj_player
function scr_player_jump()
{
	if !is_jumping
	{
		return false;
	}
	
	if !m_down_action_any()
	{
		vel_y = max(vel_y, jump_min_vel);
	}

	if vel_y < jump_min_vel || player_index > 0 && cpu_control_timer == 0
	{
		return false;
	}
	
	if input_press.action3 && super_timer == 0 && global.player_rings >= 50 && global.emerald_count == 7
	{
		audio_play_sfx(snd_transform);
		audio_play_bgm(snd_bgm_super);
		
		m_reset_substate();
		state = PLAYER_STATE.DEFAULT_LOCKED;
		animation = ANIM.TRANSFORM;
		action = ACTION.TRANSFORM;
		inv_frames = 0;
		item_inv_timer = 0;
		super_timer = 1;
		transform_timer = global.player_physics >= PHYSICS.S3 ? 26 : 36;
		image_alpha = 1;
		
		// Exit the player control routine
		return true;
	}

	switch player_type
	{
		case PLAYER.SONIC:
			
			var _shield = global.player_shields[player_index];
			
			if global.drop_dash && action == ACTION.NONE && shield_state == SHIELD_STATE.NONE && !m_down_action_any()
			{
				if super_timer > 0 || item_inv_timer > 0 || _shield <= SHIELD.NORMAL
				{
					action = ACTION.DROPDASH;
					dropdash_charge = 0;
				}
			}
			
			if !m_press_action_any() || shield_state != SHIELD_STATE.NONE || super_timer > 0 || item_inv_timer > 0
			{
				break;
			}
			
			switch _shield
			{
				case SHIELD.NONE:
				
					if !global.double_spin
					{
						break;
					}

					with obj_double_spin
					{
						if vd_target_player == other.id
						{
							instance_destroy();
						}
					}
					
					shield_state = SHIELD_STATE.DOUBLE_SPIN;
					air_lock_flag = false;
					
					instance_create(0, 0, obj_double_spin, { vd_target_player: id });
					audio_play_sfx(snd_double_spin);
					
				break;

				case SHIELD.BUBBLE:
				
					shield_state = SHIELD_STATE.ACTIVE;
					air_lock_flag = false;
					vel_x = 0;
					vel_y = 8;
					
					with obj_shield
					{
						if vd_target_player == other.id
						{
							m_animation_start(spr_shield_bubble_drop, 0, 4, 6);
						}
					}
					
					audio_play_sfx(snd_shield_bubble_2);
					
				break;

				case SHIELD.FIRE:
					
					m_set_camera_delay(16);
					shield_state = SHIELD_STATE.ACTIVE;
					air_lock_flag = true;
					vel_x = 8 * facing;
					vel_y = 0;
					
					with obj_shield
					{
						if vd_target_player == other.id
						{
							var _dash_sprite = spr_shield_fire_dash;
							
							if sprite_index != _dash_sprite
							{
								obj_set_anim(_dash_sprite, 2, 0, clear_fire_shield_dash());
							}
							else
							{
								m_animation_restart();
							}
							
							depth = m_get_layer_depth(10);
						}
					}
					
					audio_play_sfx(snd_shield_fire_2);
					
				break;

				case SHIELD.LIGHTNING:
				
					shield_state = SHIELD_STATE.DISABLED;
					air_lock_flag = false;
					vel_y = -5.5;
					
					for (var _i = 0; _i < 4; _i++)
					{
						instance_create(x, y, obj_shield_sparkle, { vd_sparkle_id: _i });
					}
					
					audio_play_sfx(snd_shield_lightning_2);
					
				break;
			}
			
		break;
		
		case PLAYER.TAILS:
		
			if action != ACTION.NONE || !m_press_action_any()
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
			solid_radius_x = radius_x_normal;
			solid_radius_y = radius_y_normal;
			
			input_down.action1 = false;
			input_down.action2 = false;
			input_down.action3 = false;
			input_press.action1 = false;
			input_press.action2 = false;
			input_press.action3 = false;
			
		break;
		
		case PLAYER.KNUCKLES:
		
			if action != ACTION.NONE || !m_press_action_any()
			{
				break;
			}
			
			animation = ANIM.GLIDE_AIR;	
			action = ACTION.GLIDE;
			action_state = GLIDE_STATE.AIR;
			air_lock_flag = false;
			is_jumping = false;
			spd_ground = 4;
			glide_value = 0;
			glide_angle = facing == -1 ? 0 : 180;
			solid_radius_x = 10;
			solid_radius_y = 10;
			vel_x = 0;
			vel_y = max(0, vel_y + 2);
			
		break;
		
		case PLAYER.AMY:
		
			if action != ACTION.NONE || !m_press_action_any()
			{
				break;
			}
			
			if !global.roll_lock
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