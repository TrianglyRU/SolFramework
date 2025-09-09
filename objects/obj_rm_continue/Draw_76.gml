/// @description Fade-Out End
if obj_game.fade_state == FADE_STATE.PLAIN_COLOUR && !audio_is_bgm_playing()
{
	game_save_data(global.current_save_slot);
	
	if time_left == 0 || continue_count == 0
	{
		global.continue_count = 0;
		global.emerald_count = 0;
		
	    room_goto(global.start_room);
	}
	else
	{
	    room_goto(global.previous_rooid);
	}
}