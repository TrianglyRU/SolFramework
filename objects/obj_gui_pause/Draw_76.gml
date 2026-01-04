/// @description Fade-Out End
if obj_game.fade_state == FADE_STATE.PLAIN_COLOUR && !audio_is_playing(snd_starpost)
{
	if state == PAUSE_STATE.RESTART
	{
		global.life_count--;
		
		game_clear_level_data();
		room_restart();
	}
	else
	{
		game_clear_level_data_all();
		room_goto(rm_level_select);
	}	
}