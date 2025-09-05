/// @description Fade-Out End
if state == GIANT_RING_STATE.ENTRY && obj_game.fade_state == FADE_STATE.PLAIN_COLOUR && !audio_is_playing(snd_warp)
{
	room_goto(rm_special);
}