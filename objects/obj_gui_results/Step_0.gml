switch state
{
    case RESULTS_STATE.LOAD:
	
        if --state_timer > 0
        {
            break;
        }
		
		// Fallthrough to RESULTS_STATE.MOVE
        state_timer = 180;
        state++;
	
    case RESULTS_STATE.MOVE:
    case RESULTS_STATE.WAIT_EXIT:
	
        if state == RESULTS_STATE.MOVE
        {
            offset_line1 = min(offset_line1 + speed_x, 0);
            offset_line2 = max(offset_line2 - speed_x, 0);
            offset_time = max(offset_time - speed_x, 0);
            offset_rings = max(offset_rings - speed_x, 0);
            offset_perfect = max(offset_perfect - speed_x, 0);
            offset_total = max(offset_total - speed_x, 0);
        }
		
		if continue_timer >= 0
		{
			if ++continue_timer == 60
			{
				audio_play_sfx(snd_continue);
			}
		}
		
        if --state_timer != 0
        {
            break;
        }
		
        if state == RESULTS_STATE.WAIT_EXIT
        {	
			state = RESULTS_STATE.EXIT;
			
            if obj_rm_stage.save_progress
            {
                game_save_data(global.current_save_slot);
            }
			
            fade_perform_black(FADE_DIRECTION.OUT, 1);
        }
		else
		{
			state = RESULTS_STATE.TALLY;
		}
		
    break;
	
    case RESULTS_STATE.TALLY:
	
        if time_bonus > 0 || ring_bonus > 0
        {
			if input_get_pressed(0).start
			{
				global.score_count += time_bonus;
				global.score_count += ring_bonus;
				
				total_bonus += time_bonus;
				total_bonus += ring_bonus;
				time_bonus = 0;
				ring_bonus = 0;
				
				break;
			}
			
            if time_bonus > 0
            {
                time_bonus -= 100;
                total_bonus += 100;
                global.score_count += 100;
            }
			
            if ring_bonus > 0
            {
                ring_bonus -= 100;
                total_bonus += 100;
                global.score_count += 100;
            }
			
            if obj_game.frame_counter % 4 == 0
            {
                audio_play_sfx(snd_beep);
            }
			
            break;
        }
		
        if total_bonus >= 10000
        {
			continue_timer = 0;
            state_timer = 300;
            global.continue_count++;  
        }
        else
        {
            state_timer = 180;
        }
		
		state = RESULTS_STATE.WAIT_EXIT;
        audio_play_sfx(snd_tally);
		
    break;
	
	case RESULTS_STATE.EXIT:
		
		if obj_game.fade_state == FADE_STATE.PLAIN_COLOUR && !audio_is_bgm_playing()
		{
			game_clear_level_data();
			
			if next_room == -1
			{
				room_restart();
			}
			else
			{
				room_goto(next_room);
			}
		}
	
	break;
}