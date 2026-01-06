switch state
{
	case GAMEOVER_STATE.SLIDE_IN:
		
		offset_x = max(offset_x - speed_x, 0);
		
		if offset_x == 0
		{
			state = GAMEOVER_STATE.WAIT;
		}
		
	break;
	
	case GAMEOVER_STATE.WAIT:
		
		var _input_press = input_get_pressed(0);
		
		if _input_press.action1 || _input_press.action2 || _input_press.action3 || wait_timer == 0
		{
			state = GAMEOVER_STATE.EXIT;
			
			audio_stop_bgm(1);
			fade_perform_black(FADE_DIRECTION.OUT, 1, function()
			{
				if audio_is_bgm_playing()
				{
					return;
				}
				
				if image_index == 1
				{
					var _checkpoint_data = global.checkpoint_data;			
			
					if array_length(_checkpoint_data) > 0
					{
						_checkpoint_data[2] = 0;
					}
		
					game_clear_level_data();
					room_restart();
				}
				else
				{
					global.life_count = 3;
					global.score_count = 0;
			
					game_clear_level_data_all();
					game_save_data(global.current_save_slot);
		
					if global.continue_count > 0
					{
						room_goto(rm_continue);
					}
					else
					{
						room_goto(global.start_room);
					}
				}
				
				return true;
			});	
		}
		else
		{
			wait_timer--;
		}
			
	break;
}