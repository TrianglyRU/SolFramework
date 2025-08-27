/// @self obj_player
/// @function scr_player_death()
function scr_player_death()
{
	gml_pragma("forceinline");
	
	switch (death_state)
	{
	    case DEATHSTATE.WAIT:
			
			var _pos_y = floor(y);
	        if (air_timer == 0)
	        {
	            var _index = camera_data.index;
	            if (_pos_y <= camera_get_y(_index) + camera_get_height(_index) + 276)
	            {
	                break;
	            }
				
	            if (player_index == 0)
	            {
	                obj_game.state = GAME_STATE.STOP_OBJECTS;
	            }
	        }
        
	        var _bound = 32;
	        var _index = camera_data.index;
			
	        if (global.player_physics < PHYSICS.S3)
	        {
	            _bound += camera_data.bottom_bound;
	        }
	        else
	        {
	            _bound += camera_get_y(_index) + camera_get_height(_index);
	        }
			
	        if (_pos_y <= _bound)
	        {
	            break;
	        }
			
	        if (player_index == 0)
	        {
	            obj_gui_hud.update_timer = false;
				
	            if (--global.life_count > 0 && obj_game.frame_counter < 36000)
	            {
	                death_state = DEATHSTATE.RESTART;
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
	            self.respawn();
	        }
			
	    break;

	    case DEATHSTATE.RESTART:
			
	        if (restart_timer > 0 && --restart_timer == 0)
	        {
			    audio_stop_bgm(1.0);	
			    fade_perform_black(FADE_DIRECTION.OUT, 1,, self.restart_after_death); 
		    }
			
	    break;
	}
}