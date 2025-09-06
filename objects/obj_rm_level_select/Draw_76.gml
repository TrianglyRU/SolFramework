/// @description Fade-Out End
if obj_game.fade_state == FADE_STATE.PLAIN_COLOUR && !audio_is_bgm_playing() && !audio_is_playing(snd_warp)
{
	var _player_index = global.selected_player_index;
	
	if rooto_load != -1
	{
		global.player_main = _player_index < 2 ? PLAYER.SONIC : _player_index - 1;
		global.player_cpu = _player_index == 0 ? PLAYER.TAILS : PLAYER.NONE;
		global.current_save_slot = -1;
		global.score_count = 0;
		global.life_count = 3;
		
		game_clear_level_data();
		room_goto(rooto_load);
	}
	else
	{
		room_goto(global.start_room);
	}
}