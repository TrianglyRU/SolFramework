/// @function scr_stage_palette_rotation()
/// @self obj_rm_stage
function scr_stage_palette_rotation()
{
	switch (room)
	{
		case rm_stage_tsz0:
			pal_run_rotation_local([0, 1, 2, 3], 6, 1, 4);
		break;
		
		case rm_stage_tsz1:
			pal_run_rotation_local([0, 1, 2, 3], 8, 1, 4);
		break;
		
		case rm_stage_tsz2:
			pal_run_rotation_local([0, 1, 2, 3], 8, 1, 4);
			pal_run_rotation_local([4, 5, 6], 8, 1, 8);
		break;
		
		default:
	}
}