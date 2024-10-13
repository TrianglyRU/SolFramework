#region DEBUG

if (global.dev_mode)
{
	var _key_collision = ord("1");
	var _key_game_speed = ord("2");
	var _key_restart_room = ord("9"); 
	var _key_restart_game = ord("0");
	var _key_profiler = vk_f1;
	var _key_console = vk_f2;
	var _key_devmenu = vk_escape;
	
	if (keyboard_check_pressed(_key_collision))
	{
		if ++global.debug_collision > 3
		{
		    global.debug_collision = 0;
		}
	}
	else if (keyboard_check_pressed(_key_game_speed))
	{
		if (game_get_speed(gamespeed_fps) != 2)
		{
		    game_set_speed(2, gamespeed_fps);
		}
		else
		{
		    game_set_speed(60, gamespeed_fps);
		}
	}
	else if (keyboard_check_pressed(_key_restart_room))
	{
		room_restart();
	}
	else if (keyboard_check_pressed(_key_restart_game))
	{
		game_restart();
	}
	else if (keyboard_check_pressed(_key_profiler))
	{
		// TODO: LTS'25
		// show_debug_overlay(!is_debug_overlay_open());
	}
	else if (keyboard_check_pressed(_key_console))
	{
		// show_debug_log(!is_debug_overlay_open());
	}
	else if (keyboard_check_pressed(_key_devmenu))
	{
		room_goto(rm_devmenu);
	}
}

#endregion

#region INPUT

var _act_1a = ord("A"), _act_1b = ord("Z");
var _act_2a = ord("S"), _act_2b = ord("X");
var _act_3a = ord("D"), _act_3b = ord("C");

ds_list_clear(input_list_gamepads);

var _max_gamepad_slots = gamepad_get_device_count();

for (var _pad_id = 0; _pad_id < _max_gamepad_slots; _pad_id++)
{
	if (gamepad_is_connected(_pad_id))
	{
		ds_list_add(input_list_gamepads, _pad_id);
	}
}

for (var _i = 0; _i < INPUT_SLOT_COUNT; _i++)
{
	var _down = input_list_down[| _i];
	var _press = input_list_press[| _i];
	var _pad_id = input_list_gamepads[| _i];
	
	if (input_vibrations[_i] >= 0)
	{
		if (input_vibrations[_i] == 0 && _pad_id != undefined)
		{
			gamepad_set_vibration(_pad_id, 0, 0);
		}
		
		input_vibrations[_i]--; 
	}
		
	if (_pad_id != undefined)
	{
	    var _lv_value = gamepad_axis_value(_pad_id, gp_axislv);
	    var _lh_value = gamepad_axis_value(_pad_id, gp_axislh);

	    _press.up = gamepad_button_check_pressed(_pad_id, gp_padu) || _lv_value < 0 && !_down.up;
	    _press.down = gamepad_button_check_pressed(_pad_id, gp_padd) || _lv_value > 0 && !_down.down;
	    _press.left = gamepad_button_check_pressed(_pad_id, gp_padl) || _lh_value < 0 && !_down.left;
	    _press.right = gamepad_button_check_pressed(_pad_id, gp_padr) || _lh_value > 0 && !_down.right;
	    _press.start = gamepad_button_check_pressed(_pad_id, gp_start);
	    _press.action1 = gamepad_button_check_pressed(_pad_id, gp_face1);
	    _press.action2 = gamepad_button_check_pressed(_pad_id, gp_face2);
	    _press.action3 = gamepad_button_check_pressed(_pad_id, gp_face4);

	    _down.up = gamepad_button_check(_pad_id, gp_padu) || _lv_value < 0;
	    _down.down = gamepad_button_check(_pad_id, gp_padd) || _lv_value > 0;
	    _down.left = gamepad_button_check(_pad_id, gp_padl) || _lh_value < 0;
	    _down.right = gamepad_button_check(_pad_id, gp_padr) || _lh_value > 0;
	    _down.start = gamepad_button_check(_pad_id, gp_start);
	    _down.action1 = gamepad_button_check(_pad_id, gp_face1);
	    _down.action2 = gamepad_button_check(_pad_id, gp_face2);
	    _down.action3 = gamepad_button_check(_pad_id, gp_face4);
	}
	else
	{
		input_reset(_down);
		input_reset(_press);
		
		if (_i != 0)
		{
			continue;
		}
	}
	
	if (_i == 0)
	{
	    _press.up |= keyboard_check_pressed(vk_up);
	    _press.down |= keyboard_check_pressed(vk_down);
	    _press.left |= keyboard_check_pressed(vk_left);
	    _press.right |= keyboard_check_pressed(vk_right);
	    _press.start |= keyboard_check_pressed(vk_enter);
	    _press.action1 |= keyboard_check_pressed(_act_1a) || keyboard_check_pressed(_act_1b);
	    _press.action2 |= keyboard_check_pressed(_act_2a) || keyboard_check_pressed(_act_2b);
	    _press.action3 |= keyboard_check_pressed(_act_3a) || keyboard_check_pressed(_act_3b);

	    _down.up |= keyboard_check(vk_up);
	    _down.down |= keyboard_check(vk_down);
	    _down.left |= keyboard_check(vk_left);
	    _down.right |= keyboard_check(vk_right);
	    _down.start |= keyboard_check(vk_enter);
	    _down.action1 |= keyboard_check(_act_1a) || keyboard_check(_act_1b);
	    _down.action2 |= keyboard_check(_act_2a) || keyboard_check(_act_2b);
	    _down.action3 |= keyboard_check(_act_3a) || keyboard_check(_act_3b);
	}
	
	_down.action_any = _down.action1 || _down.action2 || _down.action3;
	_press.action_any = _press.action1 || _press.action2 || _press.action3;
	
	if (_down.left && _down.right)
	{
	    _down.left = false;
		_down.right = false;
	    _press.left = false;
		_press.right = false;
	}
	
	if (_down.up && _down.down)
	{
	    _down.up = false;
		_down.down = false;
	    _press.up = false;
		_press.down = false;
	}
}

#endregion

#region FADE

if (fade_routine != FADEROUTINE.NONE)
{		
	if (++fade_frequency_timer >= fade_frequency_target)
	{
		fade_timer = fade_routine == FADEROUTINE.IN ? min(fade_timer + fade_step, FADE_TIMER_MAX) : max(0, fade_timer - fade_step);
		fade_frequency_timer = 0;
		
		if (fade_timer == 0 || fade_timer == FADE_TIMER_MAX)
		{
			fade_routine = FADEROUTINE.NONE;
		}
	}
	
	if (fade_game_control && fade_state != FADESTATE.ACTIVE)
	{
		state = FWSTATE.PAUSED;
	}
	
	fade_state = FADESTATE.ACTIVE;
}
else if (fade_timer == FADE_TIMER_MAX)
{
	if (fade_game_control && fade_state != FADESTATE.NONE)
	{
		state = FWSTATE.NORMAL;
	}
		
	fade_state = FADESTATE.NONE;
}
else if (fade_timer == 0)
{
	fade_state = FADESTATE.PLAINCOLOUR;
}

#endregion

#region PAUSE & FRAME COUNTER

if (state != FWSTATE.PAUSED)
{
	if (allow_pause && input_list_press[| 0].start)
	{
	    instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_pause);
	} 
	else
	{
	    frame_counter++;
	}
} 
else with (obj_gui_pause)
{
	event_perform(ev_other, ev_user0);
}

#endregion

#region CULLING

if (state != FWSTATE.NORMAL)
{
	var _min_behaviour = state == FWSTATE.STOP_OBJECTS ? CULLING.PAUSEONLY : CULLING.NONE;
	var _list = obj_framework.cull_list_pause;
	
	with (obj_instance)
	{
	    if (cull_behaviour > _min_behaviour)
		{
			ds_list_add(_list, id);
			instance_deactivate_object(id);
		}
	}
}
else 
{
	/// @feather ignore GM2016
	cull_restore_paused();
	
	for (var _i = 0; _i < CAMERA_COUNT; _i++)
	{
	    var _camera_data = camera_get_data(_i);
		
	    if (_camera_data == undefined)
		{
	        continue;
	    }
		
	    _camera_data.coarse_x = (camera_get_x(_i) - CULLING_ROUND_VALUE) & -CULLING_ROUND_VALUE;
	    _camera_data.coarse_y = (camera_get_y(_i) - CULLING_ROUND_VALUE) & -CULLING_ROUND_VALUE;
		
	    if (_camera_data.coarse_x_last == _camera_data.coarse_x && _camera_data.coarse_y_last == _camera_data.coarse_y)
		{
	        continue;
	    }
		
		_camera_data.coarse_x_last = _camera_data.coarse_x;
	    _camera_data.coarse_y_last = _camera_data.coarse_y;
		
		var _width =  camera_get_width(_i) + CULLING_ROUND_VALUE + CULLING_ADD_WIDTH - 1;
		var _height = camera_get_height(_i) + CULLING_ROUND_VALUE + CULLING_ADD_HEIGHT - 1;
		
		instance_activate_region(_camera_data.coarse_x, _camera_data.coarse_y, _width, _height, true);
	}
	
	with (obj_instance)
	{
		event_perform(ev_other, ev_user14);
	}
}

#endregion

#region PALETTE

if (state != FWSTATE.PAUSED)
{
	for (var _i = ds_list_size(palette_colours) - 1; _i >= 0; _i--)
	{
	    var _col_ind = palette_colours[| _i];
	    var _duration = palette_durations[_col_ind];
		
	    if (_duration <= 0)
	    {
	        continue;
	    }
		
	    if (--palette_timers[_col_ind] <= 0)
	    {
	        if (++palette_indices[_col_ind] > palette_end_indices[_col_ind])
	        {
	            palette_indices[_col_ind] = palette_loop_indices[_col_ind];
	        }
			
	        palette_timers[_col_ind] = _duration;
	    }
	}
	
	ds_list_clear(palette_colours);
}

#endregion

#region INSTANCE ANIMATOR

if (state != FWSTATE.PAUSED)
{
	with (obj_instance)
	{
		event_perform(ev_other, ev_user13);
	}
}

#endregion

with (obj_player)
{
	event_perform(ev_other, ev_user0);
}