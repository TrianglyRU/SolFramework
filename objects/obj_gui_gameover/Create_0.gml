// Inherit the parent event
event_inherited();

enum GAMEOVER_STATE
{
	SLIDE_IN,
	WAIT,
	EXIT
}

obj_game.allow_pause = false;

allowed_game_state = GAME_STATE.PAUSED;
state = GAMEOVER_STATE.SLIDE_IN;
wait_timer = 720;
offset_x = 208;
speed_x = 16;
image_index = global.life_count > 0 && obj_game.frame_counter >= 36000;
depth = RENDER_DEPTH_HUD;

audio_play_bgm(snd_bgm_gameover);