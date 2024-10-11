/// @function scr_player_death()
/// @self obj_player
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
	                obj_framework.state = FWSTATE.STOP_OBJECTS;
	            }
	        }
        
	        var _bound = 32;
	        var _index = camera_data.index;
			
	        if (global.player_physics < PHYSICS.S3)
	        {
	            _bound += camera_data.bound_lower;
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
				
	            if (--global.life_count > 0 && obj_framework.frame_counter < 36000)
	            {
	                death_state = DEATHSTATE.RESTART;
	                restart_timer = 60;
	            }
	            else
	            {
	                death_state--;
	                instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_gameover);
	            }
	        }
	        else
	        {
	            respawn();
	        }
			
	    break;

	    case DEATHSTATE.RESTART:
			
	        if (restart_timer > 0)
	        {
	            if (--restart_timer != 0)
	            {
	                break;
	            }
				
	            obj_set_culling(CULLING.NONE);
	            audio_stop_bgm(0.5);
	            fade_perform_black(FADEROUTINE.OUT, 1);    
	        }
			
	        if (obj_framework.fade_state != FADESTATE.PLAINCOLOUR)
	        {
	            break;
	        }
			
	        game_clear_temp_data(false);
	        room_restart();
			
	    break;
	}
}