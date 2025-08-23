enum PAUSESTATE
{
	NAVIGATION,
	RESTART,
	EXIT
}

/// @method handle_option()
handle_option = function()
{
	while (audio_is_playing(snd_starpost))
	{
		// Wait until snd_starpost is no longer playing
	}
	
	if (state == PAUSESTATE.RESTART)
	{
		global.life_count--;
				
		game_clear_level_data(false);
		room_restart();
	}
	else
	{
		game_clear_level_data();
		room_goto(rm_level_select);
	}	
}

obj_game.state = GAMESTATE.PAUSED;

state = PAUSESTATE.NAVIGATION;
highlight_timer = 0;
option_id = 0;
depth = RENDERER_DEPTH_HUD;

audio_pause_all();
audio_play_sfx(snd_bumper);