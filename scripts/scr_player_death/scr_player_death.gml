/// @self obj_player
function scr_player_death()
{
	switch death_state
	{
	    case DEATH_STATE.WAIT:
		
	        var _index = camera_data.index;
			var _cy = camera_get_y(_index);
			var _ch = camera_get_height(_index);
			var _pos_y = floor(y);
			var _bound = 32;
			
	        if air_timer == 0
	        {
	            if _pos_y <= _cy + _ch + 276
	            {
	                break;
	            }
				
	            if player_index == 0
	            {
	                obj_game.state = GAME_STATE.STOP_OBJECTS;
	            }
	        }
			
	        if global.player_physics < PHYSICS.S3
	        {
	            _bound += camera_data.bottom_bound;
	        }
	        else
	        {
	            _bound += _cy + _ch;
	        }
			
	        if _pos_y <= _bound
	        {
	            break;
	        }
			
	        if player_index == 0
	        {
	            obj_gui_hud.update_timer = false;
				
	            if --global.life_count > 0 && obj_game.frame_counter < 36000
	            {
	                death_state = DEATH_STATE.RESTART;
	                restart_timer = 60;
	            }
	            else
	            {
	                death_state--;
	                instance_create(0, 0, obj_gui_gameover);
	            }
	        }
	        else
	        {
	            m_respawn();
	        }
			
	    break;
		
	    case DEATH_STATE.RESTART:
			
	        if restart_timer > 0 && --restart_timer == 0
	        {
				if instance_exists(obj_rm_stage)
				{
					obj_rm_stage.restart = true;
				}
				
			    audio_stop_bgm(1);	
			    fade_perform_black(FADE_DIRECTION.OUT, 1); 
		    }
			
	    break;
	}
}