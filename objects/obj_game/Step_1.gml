/// @description Early Update

if room == rm_startup
{
	return;
}

// Remember current game state
var _game_state = state;

#region INPUT

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

#endregion

#region FADE

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
}
else if fade_timer == 0
{
	fade_state = FADE_STATE.PLAIN_COLOUR;
}

#endregion

#region PAUSE & FRAME COUNTER

if state != GAME_STATE.PAUSED
{
	if allow_pause && input_list_press[| 0].start
	{
	    instance_create(0, 0, obj_gui_pause);
	}
	else
	{
	    frame_counter++;
	}
} 
else with obj_gui_pause
{
	event_user(0);
}

#endregion

#region CULLING

if state == GAME_STATE.NORMAL
{
	event_user(0);
}
else
{
	var _list = cull_game_paused_list;
	var _is_empty_list = ds_list_size(_list) == 0;
	
	if state == GAME_STATE.STOP_OBJECTS
	{
		with obj_game_object
		{
			if ignore_object_stop != false
			{
				if _is_empty_list
				{
					ds_list_add(_list, id);
				}
				
				instance_deactivate_object(id);
			}
		}
	}
	else
	{
		with obj_game_object
		{
			if _is_empty_list
			{
				ds_list_add(_list, id);
			}
				
			instance_deactivate_object(id);
		}
	}
}

#endregion

#region PALETTE

if state != GAME_STATE.PAUSED
{
	for (var _i = ds_list_size(palette_rotations) - 1; _i >= 0; _i--)
	{
	    var _col_index = palette_rotations[| _i];
	    var _duration = palette_durations[_col_index];
		
	    if _duration > 0 && --palette_timers[_col_index] <= 0
	    {
	        if ++palette_indices[_col_index] > palette_end_indices[_col_index]
	        {
	            palette_indices[_col_index] = palette_loop_indices[_col_index];
	        }
			
			palette_timers[_col_index] = _duration;
	    }
	}
	
	ds_list_clear(palette_rotations);
}

#endregion

#region ANIMATOR

if state != GAME_STATE.PAUSED
{
	with obj_game_object
	{
		event_user(13);
	}
}

#endregion

// Run post-framework Begin Step for game objects
with obj_game_object
{
	event_user(10);
}

// Run active culling if previous was skipped due to game state just returning to normal
if _game_state != GAME_STATE.NORMAL && state == GAME_STATE.NORMAL
{
	event_user(0);
}