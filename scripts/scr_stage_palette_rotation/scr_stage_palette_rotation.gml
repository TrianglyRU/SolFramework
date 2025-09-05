/// @self obj_rm_stage
function scr_stage_palette_rotation()
{
	switch room
	{
		case rm_stage_ghz0:
			pal_run_rotation([30, 31, 32, 33], 6, 1, 4);
		break;
		
		case rm_stage_ehz0:
			pal_run_rotation([30, 31, 32, 33], 8, 1, 4);
		break;
		
		case rm_stage_dwz0:
		
			pal_run_rotation([30, 31, 32, 33], 6, 1, 4);
			pal_run_rotation([34], 20, 1, 8);
			
		break;
	}
}