enum PAUSESTATE
{
	NAVIGATION,
	RESTART,
	EXIT
}
	
state = PAUSESTATE.NAVIGATION;
highlight_timer = 0;
option_id = 0;
obj_framework.state = FWSTATE.PAUSED;
	
audio_pause_all();
audio_play_sfx(snd_bumper);