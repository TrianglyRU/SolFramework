switch (state)
{	
    case SPECIALRESULTSSTATE.LOAD:
	
        if (--state_timer > 0)
        {
            break;
        }
		
		// Fallthrough to SPECIALRESULTSSTATE.MOVE
        state_timer = 180;
        state = SPECIALRESULTSSTATE.MOVE;

    case SPECIALRESULTSSTATE.MOVE:
    case SPECIALRESULTSSTATE.WAIT_EXIT:
	
        offset_line1 = min(offset_line1 + speed_x, 0);
        offset_line2 = max(offset_line2 - speed_x, 0);
        offset_score = max(offset_score - speed_x, 0);
        offset_rings = max(offset_rings - speed_x, 0);
        
        if (--state_timer > 0)
        {
			break;
		}
		
        if (state == SPECIALRESULTSSTATE.WAIT_EXIT)
        {
			state = SPECIALRESULTSSTATE.EXIT;
				
            audio_play_sfx(snd_warp);
            fade_perform_white(FADEROUTINE.OUT, 1);
        }
		else
		{
			state = SPECIALRESULTSSTATE.TALLY;
		}
        		
    break;

    case SPECIALRESULTSSTATE.TALLY:
	
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
            state = SPECIALRESULTSSTATE.SUPER_MSG;
        }
        else
        {
            state_timer = 120;
            state = SPECIALRESULTSSTATE.WAIT_EXIT;
        }
		
        audio_play_sfx(snd_tally);
		
    break;

    case SPECIALRESULTSSTATE.SUPER_MSG:
	
        offset_line1 = max(offset_line1 - speed_x * 2, SPECIALRESULTS_OFFSET_LINE_1);
        offset_line2 = min(offset_line2 + speed_x * 2, SPECIALRESULTS_OFFSET_LINE_2);
        
        if (offset_line1 == SPECIALRESULTS_OFFSET_LINE_1 && offset_line2 == SPECIALRESULTS_OFFSET_LINE_2)
        {
            message_super = true;
            state_timer = 180;
            state = SPECIALRESULTSSTATE.WAIT_EXIT;
        }
		
    break;

    case SPECIALRESULTSSTATE.EXIT:
	
        if (obj_game.fade_state != FADESTATE.PLAINCOLOUR)
        {
            break;
        }
		
        if (visible)
        {
			visible = false;
            fade_perform_black(FADEROUTINE.OUT, 1); 
        }
		
        if (!audio_is_playing(snd_warp))
        {
            room_goto(global.previous_room_id);
        }
		
    break;
}