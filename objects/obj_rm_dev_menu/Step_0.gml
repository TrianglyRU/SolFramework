var _input_press = input_get_pressed(0);
if (_input_press.down)
{
	if (++option_id >= category_options_count)
	{
		option_id = 0;
	}
}
else if (_input_press.up)
{
	if (--option_id < 0)
	{
		option_id = category_options_count - 1;
	}
}

if (_input_press.action3 && category_id == 1 && option_id > 0)
{	
	alter_option(option_id, "SAVE " + string(option_id - 1));
	
	game_delete_data(option_id - 1);
	return;
}

if (_input_press.action2)
{
	if (category_id == 3)
	{
		game_save_settings();
	}
	
	load_category(all_categories_data[? category_id][0]);
	return;
}

// Handle input based on the current category
switch (category_id)
{
	case 3:
		
		// For settings menu, react only to left & right inputs
		if (!_input_press.left && !_input_press.right)
		{
			return;
		}
		
	break;
	
	default:
		
		// For everything else, react only to action1 and start inputs
		if (!_input_press.action1 && !_input_press.start)
		{
			return;
		}
}

// Handle actions for each menu category
switch (category_id)
{	
	// Main menu
	case 0:
	
		switch (option_id)
		{
			case 0:
			
				load_category(1);	
				
				for (var _i = 0; _i < 4; _i++)
				{
					if (game_check_data(_i))
					{
						alter_option(_i + 1, "SAVED GAME " + string(_i));
					}
				}
				
			break;
			
			case 1:	
			
				if (global.dev_mode)
				{
					load_category(2);
				}
				else
				{
					audio_play_sfx(snd_fail);
				}	
				
			break;
			
			case 2:
				load_category(3);
			break;
			
			case 3:
				game_end();
			break;
		}
		
	break;
	
	// Start game
	case 1:	
	
		global.current_save_slot = option_id - 1;

		if !game_check_data(global.current_save_slot)
		{
			room_to_load = rm_stage_ghz1;
			load_category(4);
			
			break;
		}
		
		game_clear_level_data_all();
		game_load_data(global.current_save_slot);
		
		switch (global.stage_index)
		{
			default:
				room_goto(rm_stage_ghz1);
		}
		
	break;
	
	// Room selection
	case 2:	
	
		// Add 1 because we're skipping the rm_startup entry
		room_to_load = option_id + 1;
		
		if (room_to_load < 0)
		{
			audio_play_sfx(snd_fail);
		}
		else
		{
			load_category(4);
			global.current_save_slot = -1;
		}
		
	break;
	
	// Settings menu
	case 3:	
	
		switch (option_id)
		{
			case 0:
			
				global.gamepad_rumble = !global.gamepad_rumble;
				if (global.gamepad_rumble)
				{
					input_set_rumble(0, 0.15, INPUT_RUMBLE_MEDIUM);
				}
				
			break;
			
			case 1:
			
				if (_input_press.left)
				{
					global.music_volume -= 0.1;
				}
				else if (_input_press.right)
				{
					global.music_volume += 0.1;
				}
				else
				{
					break;
				}

				global.music_volume = clamp(global.music_volume, 0, 1);
				audio_play_bgm(snd_bgm_actclear);
				
			break;
			
			case 2:
			
				if (_input_press.left)
				{
					global.sound_volume -= 0.1;
				}
				else if (_input_press.right)
				{
					global.sound_volume += 0.1;
				}
				else
				{
					break;
				}

				global.sound_volume = clamp(global.sound_volume, 0, 1);
				audio_play_ring_sfx();
				
			break;
			
			case 3:
			
				if (_input_press.left)
				{
					global.window_scale--;
				}
				else if (_input_press.right)
				{
					global.window_scale++;
				}
				else
				{
					break;
				}
				
				/// @feather ignore GM1041
				global.window_scale = clamp(global.window_scale, 1, 4);	
				window_resize();
				
			break;
			
			case 4:
				window_set_fullscreen(_input_press.right);				
			break;
			
			case 5:
			
				global.use_vsync = _input_press.right;
				display_reset(0, global.use_vsync);
				
			break;
		}
		
		alter_setting(option_id);
		
	break;
	
	// Player 1 selection
	case 4:	
	
		global.player_main = option_id;
		load_category(5);
		
	break;
	
	// Player 2 selection
	case 5:
	
		global.player_cpu = option_id == (category_options_count - 1) ? PLAYER.NONE : option_id;
		global.continue_count = 3;
		global.emerald_count = 7;
		global.score_count = 0;
		global.life_count = 3;
		
		game_clear_level_data_all();
		game_save_data(global.current_save_slot);
		room_goto(room_to_load);
		
	break;
}