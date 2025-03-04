/// @description Post-Begin Step

scr_player_input();

switch (state)
{
	case PLAYERSTATE.DEFAULT:
	case PLAYERSTATE.LOCKED:
		
		if (scr_player_debug_mode_enter())
		{
			break;  
		}
		
		scr_player_parameters();
		scr_player_cpu();
		
		if (state != PLAYERSTATE.LOCKED) then switch (is_grounded)
		{
			// Grounded
			case true:
				
				if (scr_player_spindash() || scr_player_dash())
				{
					break;
				}
				
				if (scr_player_jump_start())
				{
					// Just like above, originals skip this, causing a one-frame lag. Avoiding that for jumps!
					scr_player_position(); 
					break;
				}
				
				scr_player_hammerdash();
				
				if (animation == ANIM.SPIN)
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
				
				if (animation != ANIM.SPIN)
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
				
				if (scr_player_jump())
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
				
				if (action != ACTION.CARRIED)
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
		
		record_data(0);
		
	break;

	case PLAYERSTATE.HURT:
		
		if (scr_player_debug_mode_enter())
		{
			break;
		}
		
		scr_player_level_bound();
		scr_player_position();
		scr_player_collision_air();
		scr_player_animate();
		
		record_data(0);
		
	break;

	case PLAYERSTATE.DEATH:
		
		if (scr_player_debug_mode_enter())
		{
			break;
		}
		
		scr_player_death();
		scr_player_position();
		scr_player_animate();
		
		record_data(0);
		
	break;

	case PLAYERSTATE.DEBUG_MODE:
		scr_player_debug_mode();
	break;
	
	case PLAYERSTATE.RESPAWN:
	
		if (camera_data.vel_x == 0 && camera_data.vel_y == 0)
		{
			state = PLAYERSTATE.DEFAULT;
		}
		
	break;
}

scr_player_update_collision();
scr_player_palette();