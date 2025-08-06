/// @description Early Update
if (room == rm_startup)
{
	return;
}

// Remember the current game state
var _game_state = state;

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
		state = GAMESTATE.PAUSED;
	}
	
	fade_state = FADESTATE.ACTIVE;
}
else if (fade_timer == FADE_TIMER_MAX)
{
	if (fade_game_control && fade_state != FADESTATE.NONE)
	{
		state = GAMESTATE.NORMAL;
	}
		
	fade_state = FADESTATE.NONE;
}
else if (fade_timer == 0)
{
	fade_state = FADESTATE.PLAINCOLOUR;
}

#endregion

#region PAUSE & FRAME COUNTER

if (state != GAMESTATE.PAUSED)
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

if (state != GAMESTATE.NORMAL)
{
	var _banned_behaviour = state == GAMESTATE.STOP_OBJECTS ? ACTIVEIF.OBJECTS_ACTIVE : ACTIVEIF.ENGINE_RUNNING;
	var _list = cull_game_paused_list;
	var _is_empty_list = ds_list_size(_list) == 0;
	
	with (obj_game_object)
	{
	    if (cull_behaviour >= _banned_behaviour)
		{
			// Remember this object, once
			if (_is_empty_list)
			{
				ds_list_add(_list, id);
			}
			
			instance_deactivate_object(id);
		}
	}
}
else
{
	// Run culling
	event_user(0);
}

#endregion

#region PALETTE

if (state != GAMESTATE.PAUSED)
{
	for (var _i = ds_list_size(palette_rotations) - 1; _i >= 0; _i--)
	{
	    var _col_ind = palette_rotations[| _i];
	    var _duration = palette_durations[_col_ind];
		
	    if (_duration <= 0)
	    {
	        continue;
	    }
		
	    if (--palette_timers[_col_ind] <= 0)
	    {
			palette_timers[_col_ind] = _duration;
	        if (++palette_indices[_col_ind] > palette_end_indices[_col_ind])
	        {
	            palette_indices[_col_ind] = palette_loop_indices[_col_ind];
	        }
	    }
	}
	
	ds_list_clear(palette_rotations);
}

#endregion

#region INSTANCE ANIMATOR

if (state != GAMESTATE.PAUSED)
{
	with (obj_game_object)
	{
		event_perform(ev_other, ev_user13);
	}
}

#endregion

// Run post-framework Begin Step for objects
with (obj_game_object)
{
	event_user(10);
}

// Run culling if previous was skipped due to game state just returning to normal
if (_game_state != GAMESTATE.NORMAL && state == GAMESTATE.NORMAL)
{
	event_user(0);
}