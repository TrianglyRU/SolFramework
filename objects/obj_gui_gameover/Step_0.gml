switch (state)
{
	case GAMEOVERSTATE.SLIDE_IN:
		
		offset_x = max(offset_x - speed_x, 0);
		if (offset_x == 0)
		{
			state = GAMEOVERSTATE.WAIT;
		}
		
	break;
	
	case GAMEOVERSTATE.WAIT:
			
		if (input_get_pressed(0).action_any || wait_timer == 0)
		{
			state++;
			
			audio_stop_bgm(1.0);
			fade_perform_black(FADEDIRECTION.OUT, 1,, function()
			{
				if (image_index == 1)
				{
					var _checkpoint_data = global.checkpoint_data;			
					if (array_length(_checkpoint_data) > 0)
					{
						_checkpoint_data[2] = 0;
					}
		
					game_clear_level_data(false);
					room_restart();
				}
				else
				{
					global.life_count = 3;
					global.score_count = 0;
					
					game_clear_level_data();
					game_save_data(global.current_save_slot);
		
					if (global.continue_count > 0)
					{
						room_goto(rm_continue);
					}
					else
					{
						room_goto(global.start_room);
					}
				}
			});	
			
			break;
		}
		
		wait_timer--;
			
	break;
}