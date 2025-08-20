/// Called in obj_game -> Begin Step
/// @self obj_gui_pause
if (state != PAUSESTATE.NAVIGATION)
{
	return;
}

highlight_timer = (highlight_timer + 1) % 16;

var _input = input_get_pressed(0);	
var _option_id = option_id;

if (_input.down)
{
	if (++option_id > 2)
	{
		option_id = 0;
	}
}
else if (_input.up)
{
	if (--option_id < 0)
	{
		option_id = 2;
	}
}
		
if (option_id != _option_id)
{
	audio_play_sfx(snd_beep);
}

if (!_input.action_any && !_input.start)
{
	return;
}

if (option_id == 0)
{
	obj_game.state = GAMESTATE.NORMAL;
	
	audio_resume_all();
	instance_destroy();
	input_reset(_input);	
	audio_play_sfx(snd_starpost);
	
	return;
}

if (option_id == 1)
{
	if (player_get(0).state == PLAYERSTATE.DEATH || global.life_count == 1)
	{
		audio_play_sfx(snd_fail);
		return;
	}
	
	state = PAUSESTATE.RESTART;
}
else
{
	state = PAUSESTATE.EXIT;
}
		
audio_play_sfx(snd_starpost);
fade_perform_black(FADEDIRECTION.OUT, 1,, function()
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
});