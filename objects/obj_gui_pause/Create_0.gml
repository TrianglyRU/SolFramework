// Inherit the parent event
event_inherited();

enum PAUSE_STATE
{
	NAVIGATION,
	RESTART,
	EXIT
}

obj_game.state = GAME_STATE.PAUSED;

depth = RENDER_DEPTH_HUD;
ignored_game_state = GAME_STATE.PAUSED;
state = PAUSE_STATE.NAVIGATION;
highlight_timer = 0;
option_id = 0;

audio_pause_all();
audio_play_sfx(snd_bumper);