/// @self obj_player
function scr_player_debug_mode_init()
{
	debug_mode_ind = 0;
	debug_mode_spd = 0;
	debug_mode_array =
	[
		obj_ring,
		obj_item_box,
		obj_starpost,
		obj_spring_v_yellow,
		obj_spring_v_red,
		obj_spring_h_yellow,
		obj_spring_h_red,
		obj_spring_d_yellow,
		obj_spring_d_red,
		obj_spikes_v,
		obj_spikes_h,
		obj_giant_ring,
		obj_signpost,
		obj_capsule
	];
	
	// array_push()
	switch room
	{
		case rm_stage_ghz1:
		
			array_push
			(
				debug_mode_array, 
				obj_breakable_wall_ghz, 
				obj_bridge_ghz,
				obj_helix_pole,
				obj_ledge_ghz,
				obj_platform_ghz,
				obj_platform_swing_ghz,
				obj_points,
				obj_rock_ghz,
				obj_wall,
				obj_waterfall_sound,
				obj_buzz_bomber,
				obj_chopper,
				obj_crabmeat,
				obj_moto_bug,
				obj_newtron
			);
			
		break;
		
		case rm_stage_ehz1:
		
			array_push
			(
				debug_mode_array,
				obj_bridge_ehz,
				obj_platform_ehz,
				obj_spiral_path,
				obj_waterfall,
				obj_buzzer,
				obj_coconuts,
				obj_masher
			);
		
		break;
		
		case rm_stage_ssz1:
		
			array_push
			(
				debug_mode_array,
				obj_bridge_ssz,
				obj_convex,
				obj_falling_floor_ssz,
				obj_parachute,
				obj_platform_ssz,
				obj_platform_swing_ssz,
				obj_tube,
				obj_chompy,
				obj_frog_o_matic,
				obj_helibomber,
				obj_moto_rally
			);
			
		break;
		
		case rm_stage_dwz:
		
			array_push
			(
				debug_mode_array,
				obj_block_dwz,
				obj_breakable_wall_dwz,
				obj_bumper,
				obj_falling_floor_dwz,
				obj_platform_dwz,
				obj_pushable_block_dwz,
				obj_solid_dwz,
				obj_spiral_path,
				obj_platform_swing_ghz,
				obj_buzzer,
				obj_chopper,
				obj_crabmeat,
				obj_moto_bug,
				obj_newtron,
				obj_sol
			);
			
		break;
		
		default:
	}
}