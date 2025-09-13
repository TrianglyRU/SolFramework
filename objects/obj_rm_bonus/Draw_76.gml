/// @description Fade-Out End
if obj_game.fade_state == FADE_STATE.PLAIN_COLOUR && !audio_is_bgm_playing()
{
	room_goto(global.previous_room_id);
}