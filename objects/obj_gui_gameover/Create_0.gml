enum GAMEOVERSTATE
{
	SLIDE_IN,
	WAIT
}

/// @method handle_gameover_end()
handle_gameover_end = function()
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
}

obj_game.allow_pause = false;

state = GAMEOVERSTATE.SLIDE_IN;
wait_timer = 720;
offset_x = 208;
speed_x = 16;
image_index = global.life_count > 0 && obj_game.frame_counter >= 36000;
depth = RENDER_DEPTH_HUD;

audio_play_bgm(snd_bgm_gameover);