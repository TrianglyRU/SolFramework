/// @self obj_player
/// @function scr_player_debug_mode_enter()
function scr_player_debug_mode_enter()
{
	if (player_index > 0 || !global.dev_mode && !global.enable_debug_mode)
	{
	    return false;
	}
	
	if (state == PLAYERSTATE.DEATH && death_state != DEATHSTATE.WAIT)
	{
		return false;
	}
	
	if (input_press.action2)
	{
		obj_reset_priority();
		
		image_alpha = 1.0;
		visible = true;
	    state = PLAYERSTATE.DEBUG_MODE;
		
		if (camera_data.index == player_index)
		{
			camera_data.allow_movement = true;
		}
		
		if (obj_game.state == GAME_STATE.STOP_OBJECTS)
	    {
	        obj_game.state = GAME_STATE.NORMAL;
	    }
		
		if (instance_exists(obj_rm_stage) && (audio_is_playing(snd_bgm_drowning) || !audio_is_bgm_playing()))
		{
			audio_reset_bgm(obj_rm_stage.bgm_track, id);
		}
	    
		// Exit the player control routine
	    return true;
	}

	return false;
}
