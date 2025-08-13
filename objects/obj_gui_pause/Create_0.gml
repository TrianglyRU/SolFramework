enum PAUSESTATE
{
	NAVIGATION,
	RESTART,
	EXIT
}

obj_game.state = GAMESTATE.PAUSED;

state = PAUSESTATE.NAVIGATION;
highlight_timer = 0;
option_id = 0;

audio_pause_all();
audio_play_sfx(snd_bumper);