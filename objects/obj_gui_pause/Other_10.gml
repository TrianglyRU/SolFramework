/// Called in obj_framework -> Begin Step
/// @self obj_gui_pause

var _input = input_get_pressed(0);

switch (state)
{
	case PAUSESTATE.NAVIGATION:
	
		highlight_timer = (highlight_timer + 1) % 16;
		
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
			break;
		}
		
		if (option_id == 0)
		{
			obj_framework.state = FWSTATE.NORMAL;
			
			audio_resume_all();
			instance_destroy();
			input_reset(_input);	
			audio_play_sfx(snd_starpost);
			
			break;
		}
		
		if (option_id == 1)
		{
			if (player_get(0).state == PLAYERSTATE.DEATH)
			{
				audio_play_sfx(snd_fail);
				break;
			}
			
			state = PAUSESTATE.RESTART;
		}
		else
		{
			state = PAUSESTATE.EXIT;
		}
		
		audio_play_sfx(snd_starpost);
		fade_perform_black(FADEROUTINE.OUT, 1);
		
	break;

	case PAUSESTATE.RESTART:
	case PAUSESTATE.EXIT:
	
		if (obj_framework.fade_state != FADESTATE.PLAINCOLOUR || audio_is_playing(snd_starpost))
		{
			break;
		}	
		
		if (state == PAUSESTATE.RESTART)
		{
			game_clear_temp_data(false);
			room_restart();
		}
		else
		{
			game_clear_temp_data();
			room_goto(rm_devmenu);
		}
		
	break;
}