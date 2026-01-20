/// @self obj_rm_dev_menu
function scr_menu_start_load_game()
{
	var _new_game_stage = rm_stage_ghz1;
	
	// If no save data exist, load into the first stage
	if !game_check_data(global.current_save_slot)
	{
		return _new_game_stage;
	}
	
	game_load_data(global.current_save_slot);
	game_clear_level_data_all();
	
	switch global.game_progress_value
	{
		// Load into the stage that follows the one we completed last
		case 97: room_goto(rm_stage_ehz1); break;
		case 98: room_goto(rm_stage_ssz1); break;
		
		case GAME_PROGRESS_MAX:
			room_goto(rm_level_select);
		break;
		
		default:
			room_goto(_new_game_stage);
	}
	
	return undefined;
}