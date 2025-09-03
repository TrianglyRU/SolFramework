/// @description Begin Step (Post-Framework)
scr_player_input();

switch state
{
	case PLAYER_STATE.DEFAULT:
	case PLAYER_STATE.DEFAULT_LOCKED:
		
		if scr_player_debug_mode_enter()
		{
			break;
		}
		
		scr_player_parameters();
		scr_player_cpu();
		
		if state != PLAYER_STATE.DEFAULT_LOCKED then switch is_grounded
		{
			// Grounded
			case true:
				
				if scr_player_spindash() || scr_player_dash() || scr_player_jump_start()
				{
					break;
				}
				
				scr_player_hammerdash();
				
				if animation == ANIM.SPIN
				{
					scr_player_slope_resist_roll();
					scr_player_movement_roll();
				}
				else
				{
					scr_player_slope_resist();
					scr_player_movement_ground();
					scr_player_balance();
				}
				
				scr_player_collision_ground_walls();
				
				if animation != ANIM.SPIN
				{
					scr_player_roll_start();
				}
				
				scr_player_level_bound();
				scr_player_position();
				scr_player_collision_ground_floor();
				scr_player_slope_repel();
				
			break;
			
			// Airborne
			case false:
				
				if scr_player_jump()
				{
					break;
				}
				
				scr_player_dropdash();
				scr_player_flight();
				scr_player_climb();
				scr_player_glide();
				scr_player_hammerspin();
				scr_player_hammerdash();
				scr_player_movement_air();
				scr_player_level_bound();
				
				if action != ACTION.CARRIED
				{
					scr_player_position();
					scr_player_collision_air();
				}
				
				scr_player_glide_collision();
				
			break;
		}
		
		scr_player_carry();
		scr_player_water();
		scr_player_update_status();
		scr_player_animate();
		scr_player_update_collision();
		scr_player_check_objects();
		
		m_record_data(0);
		
	break;

	case PLAYER_STATE.HURT:
		
		if scr_player_debug_mode_enter()
		{
			break;
		}
		
		scr_player_level_bound();
		scr_player_position();
		scr_player_collision_air();
		scr_player_animate();
		scr_player_update_collision();
		
		m_record_data(0);
		
	break;

	case PLAYER_STATE.DEATH:
		
		if scr_player_debug_mode_enter()
		{
			break;
		}
		
		scr_player_death();
		scr_player_position();
		scr_player_animate();
		scr_player_update_collision();
		
		m_record_data(0);
		
	break;

	case PLAYER_STATE.DEBUG_MODE:
		scr_player_debug_mode();
	break;
	
	case PLAYER_STATE.RESPAWN:
		
		// Don't do anything until the camera finds us
		if camera_data.vel_x == 0 && camera_data.vel_y == 0
		{
			state = PLAYER_STATE.DEFAULT;
		}
		
	break;
}

scr_player_palette();