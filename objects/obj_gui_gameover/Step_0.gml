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
			
			audio_stop_bgm(1);
			fade_perform_black(FADE_DIRECTION.OUT, 1,, handle_gameover_end);	
		}
		else
		{
			wait_timer--;
		}
			
	break;
}