switch (state)
{	
    case SPECIALRESULTS_STATE.LOAD:
	
        if (--state_timer > 0)
        {
            break;
        }
		
		// Fallthrough to SPECIALRESULTS_STATE.MOVE
        state_timer = 180;
        state = SPECIALRESULTS_STATE.MOVE;

    case SPECIALRESULTS_STATE.MOVE:
    case SPECIALRESULTS_STATE.WAIT_EXIT:
	
        offset_line1 = min(offset_line1 + speed_x, 0);
        offset_line2 = max(offset_line2 - speed_x, 0);
        offset_score = max(offset_score - speed_x, 0);
        offset_rings = max(offset_rings - speed_x, 0);
        
        if (--state_timer > 0)
        {
			break;
		}
		
        if (state == SPECIALRESULTS_STATE.WAIT_EXIT)
        {
			state = SPECIALRESULTS_STATE.EXIT;
			
            audio_play_sfx(snd_warp);
            fade_perform_white(FADE_DIRECTION.OUT, 1,, start_black_fade_out);
        }
		else
		{
			state = SPECIALRESULTS_STATE.TALLY;
		}
        		
    break;
	
    case SPECIALRESULTS_STATE.TALLY:
	
        if (ring_bonus > 0)
        {
            ring_bonus--;
            total_score += 100;
            global.score_count += 100;
			
            if (obj_game.frame_counter % 4 == 0)
            {
                audio_play_sfx(snd_beep);
            }
			
            break;
        }
        
        if (global.emerald_count == 7)
        {
            state = SPECIALRESULTS_STATE.SUPER_MSG;
        }
        else
        {
            state_timer = 120;
            state = SPECIALRESULTS_STATE.WAIT_EXIT;
        }
		
        audio_play_sfx(snd_tally);
		
    break;
	
    case SPECIALRESULTS_STATE.SUPER_MSG:
	
        offset_line1 = max(offset_line1 - speed_x * 2, SPECIALRESULTS_OFFSET_LINE_1);
        offset_line2 = min(offset_line2 + speed_x * 2, SPECIALRESULTS_OFFSET_LINE_2);
        
        if (offset_line1 == SPECIALRESULTS_OFFSET_LINE_1 && offset_line2 == SPECIALRESULTS_OFFSET_LINE_2)
        {
            message_super = true;
            state_timer = 180;
            state = SPECIALRESULTS_STATE.WAIT_EXIT;
        }
		
    break;
}