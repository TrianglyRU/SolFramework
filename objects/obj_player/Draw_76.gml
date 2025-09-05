/// @description Fade-Out End
if death_state == DEATH_STATE.RESTART && obj_game.fade_state == FADE_STATE.PLAIN_COLOUR && !audio_is_bgm_playing()
{
	game_clear_level_data(false);
	room_restart();
}