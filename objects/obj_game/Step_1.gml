/// @description Early Update
if room == rm_startup
{
	return;
}

// Remember current game state
var _prev_state = state;

// Read input
var _act_1a = ord("A"), _act_1b = ord("Z");
var _act_2a = ord("S"), _act_2b = ord("X");
var _act_3a = ord("D"), _act_3b = ord("C");
var _pads = global.gamepad_list;

for (var _i = 0; _i < INPUT_SLOT_COUNT; _i++)
{
	var _down = input_list_down[| _i];
	var _press = input_list_press[| _i];
	var _pad_index = _pads[| _i];
	
	// >= 0 to reset rumble if current room has changed
	if input_rumble_time_left[_i] >= 0
	{
		if --input_rumble_time_left[_i] <= 0 && _pad_index != undefined
		{
			gamepad_set_vibration(_pad_index, 0, 0);
		}
	}
	
	if _pad_index != undefined
	{
		var _lv_value = gamepad_axis_value(_pad_index, gp_axislv);
        var _lh_value = gamepad_axis_value(_pad_index, gp_axislh);
        var _hat_value = gamepad_hat_value(_pad_index, 0);
		
        var _face1 = _pad_index < 4 ? gp_face1 : gp_face2;
        var _face2 = _pad_index < 4 ? gp_face2 : gp_face3;
        var _face4 = gp_face4;
		
		var _analog_up = _hat_value == 1 || _lv_value < 0;
		var _analog_down = _hat_value == 4 || _lv_value > 0;
		var _analog_left = _hat_value == 8 || _lh_value < 0;
		var _analog_right = _hat_value == 2 || _lh_value > 0;
		
	    _press.up = gamepad_button_check_pressed(_pad_index, gp_padu) || _analog_up && !_down.up;
	    _press.down = gamepad_button_check_pressed(_pad_index, gp_padd) || _analog_down && !_down.down;
	    _press.left = gamepad_button_check_pressed(_pad_index, gp_padl) || _analog_left && !_down.left;
	    _press.right = gamepad_button_check_pressed(_pad_index, gp_padr) || _analog_right && !_down.right;
	    _press.start = gamepad_button_check_pressed(_pad_index, gp_start);
	    _press.action1 = gamepad_button_check_pressed(_pad_index, _face1);
	    _press.action2 = gamepad_button_check_pressed(_pad_index, _face2);
	    _press.action3 = gamepad_button_check_pressed(_pad_index, _face4);
		
	    _down.up = gamepad_button_check(_pad_index, gp_padu) || _analog_up;
	    _down.down = gamepad_button_check(_pad_index, gp_padd) || _analog_down;
	    _down.left = gamepad_button_check(_pad_index, gp_padl) || _analog_left;
	    _down.right = gamepad_button_check(_pad_index, gp_padr) || _analog_right;
	    _down.start = gamepad_button_check(_pad_index, gp_start);
	    _down.action1 = gamepad_button_check(_pad_index, _face1);
	    _down.action2 = gamepad_button_check(_pad_index, _face2);
	    _down.action3 = gamepad_button_check(_pad_index, _face4);
	}
	else
	{
		input_reset(_down);
		input_reset(_press);
		
		// No need to check for double input
		if _i != 0
		{
			continue;
		}
	}
	
	if _i == 0
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
	
	if _down.left && _down.right
	{
	    _down.left = false;
		_down.right = false;
	    _press.left = false;
		_press.right = false;
	}
	
	if _down.up && _down.down
	{
	    _down.up = false;
		_down.down = false;
	    _press.up = false;
		_press.down = false;
	}
}

// Handle fade system
if fade_direction != FADE_DIRECTION.NONE
{
	if ++fade_frequency_timer >= fade_frequency_target
	{
		fade_timer = fade_direction == FADE_DIRECTION.IN ? min(fade_timer + fade_step, FADE_TIMER_MAX) 
														 : max(0, fade_timer - fade_step);
		fade_frequency_timer = 0;
		
		// Once reached target timer value, change fade_state on the next frame
		if fade_timer == 0 || fade_timer == FADE_TIMER_MAX
		{
			fade_direction = FADE_DIRECTION.NONE;
		}
	}
	
	if fade_state != FADE_STATE.ACTIVE && fade_game_control
	{
		state = GAME_STATE.PAUSED;
	}
	
	fade_state = FADE_STATE.ACTIVE;
}
else if fade_timer == FADE_TIMER_MAX
{
	if fade_state != FADE_STATE.NONE && fade_game_control
	{
		state = GAME_STATE.NORMAL;
	}
	
	fade_state = FADE_STATE.NONE;
	
	if fade_in_action != undefined && is_method(fade_in_action)
	{
		if fade_in_action()
		{
			fade_in_action = undefined;
		}
	}
}
else if fade_timer == 0
{
	fade_state = FADE_STATE.PLAIN_COLOUR;
	
	if fade_out_action != undefined && is_method(fade_out_action)
	{
		if fade_out_action()
		{
			fade_out_action = undefined;
		}
	}
}

// Handle the manual pause
if state != GAME_STATE.PAUSED
{
	if allow_pause && input_list_press[| 0].start
	{
	    instance_create(0, 0, obj_gui_pause);
	}
} 
else with obj_gui_pause
{
	event_user(0);
}

// Cull objects while the framework is active
if state == GAME_STATE.NORMAL
{
	for (var _i = 0; _i < CAMERA_COUNT; _i++)
	{
		var _camera_data = camera_get_data(_i);
	
		if _camera_data == undefined
		{
			continue;
		}
		
		_camera_data.coarse_x = (camera_get_x(_i) - CULLING_ROUND_VALUE) & -CULLING_ROUND_VALUE;
		_camera_data.coarse_y = (camera_get_y(_i) - CULLING_ROUND_VALUE) & -CULLING_ROUND_VALUE;
		
		if _camera_data.coarse_x_last != _camera_data.coarse_x || _camera_data.coarse_y_last != _camera_data.coarse_y
		{
			_camera_data.coarse_x_last = _camera_data.coarse_x;
			_camera_data.coarse_y_last = _camera_data.coarse_y;
			
			// Should be the same in ConstCuller.run()
			var _w = camera_get_width(_i) + CULLING_ROUND_VALUE + CULLING_ADD_WIDTH;
			var _h = camera_get_height(_i) + CULLING_ROUND_VALUE + CULLING_ADD_HEIGHT;
			
			instance_activate_region(_camera_data.coarse_x, _camera_data.coarse_y, _w - 1, _h - 1, true);
		}
	}
	
	with obj_gameobject
	{
		if culler != noone
		{
			culler.run();
		}
	}
}

// Stop objects while the framework is paused
else
{
	var _list = cull_game_paused_list;
	var _state = state;
	
	with obj_gameobject
	{
		if allowed_game_state < _state
		{
			ds_list_add(_list, id);
			instance_deactivate_object(id);
		}
	}
}

if state != GAME_STATE.PAUSED
{
	// Frame counter
	frame_counter++;
	oscillation_angle = frame_counter * ANGLE_INCREMENT;
	
	// Instance animator
	with obj_gameobject
	{
		if animator != noone
		{
			animator.update();
		}
	}
	
	// Palette rotation
	for (var _i = 0; _i < PALETTE_TOTAL_SLOT_COUNT; _i++)
	{
		var _duration = palette_durations[_i];
		
		if _duration > 0 && --palette_timers[_i] <= 0
		{
		    if ++palette_indices[_i] > palette_end_indices[_i]
		    {
		        palette_indices[_i] = palette_loop_indices[_i];	
		    }
				
			palette_timers[_i] = _duration;
		}
	}
}

// Run post-framework Begin Step for game objects
with obj_gameobject
{
	event_user(11);
}

// Activate stopped objects to process them if the game state has returned to normal
if state == GAME_STATE.NORMAL && _prev_state != state
{
	restore_stopped_objects();
}