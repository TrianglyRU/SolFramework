/// @self obj_player
/// @function scr_player_debug_mode_init()
function scr_player_debug_mode_init()
{
	debug_mode_ind = 0;
	debug_mode_spd = 0;
	debug_mode_array =
	[
		obj_ring,
		obj_itembox,
		obj_starpost,
		obj_spring_v_yellow,
		obj_spring_v_red,
		obj_spring_h_yellow,
		obj_spring_h_red,
		obj_spring_d_yellow,
		obj_spring_d_red,
		obj_giant_ring
	];
	
	// array_push()
	switch (room)
	{
		case rm_stage_ghz0:
			array_push(debug_mode_array, obj_crabmeat);
		break;
		
		default:
	}
}