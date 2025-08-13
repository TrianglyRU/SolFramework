/// @description Draw Debug
if (room == rm_startup)
{
	return;
}

if (global.dev_mode)
{
	var _list;
	var _list_size;

	switch (global.debug_collision)
	{
		// Draw collision sensors
		case 1:
	
			_list = debug_tile_sensors;
			_list_size = ds_list_size(debug_tile_sensors);
		
			if (_list_size == 0)
			{
				break;
			}
		
			for (var _i = 0; _i < _list_size; _i += 5)
			{
				var _line_col1 = _list[| _i + 4];
				var _line_col2 = make_colour_hsv(colour_get_hue(_line_col1), colour_get_saturation(_line_col1) - 128, 255);
				
				draw_line_floored(_list[| _i], _list[| _i + 1], _list[| _i + 2], _list[| _i + 3], _line_col1, _line_col2);
			}
		
		break;
	
		// Draw hitboxes
		case 2:
	
			_list = debug_interact
			_list_size = ds_list_size(_list);
		
			if (_list_size == 0)
			{
				break;
			}
		
			draw_set_alpha(0.5);
		
			for (var _i = 0; _i < _list_size; _i += 6)
			{
				draw_rect_floored(_list[| _i], _list[| _i + 1], _list[| _i + 2], _list[| _i + 3], false, _list[| _i + 4]);
			}
		
			draw_set_alpha(1.0);
		
		break;
	
		// Draw solids
		case 3:
		
			_list = debug_solids
			_list_size = ds_list_size(_list);
		
			if (_list_size == 0)
			{
				break;
			}
		
			draw_set_alpha(0.5);
		
			for (var _i = 0; _i < _list_size; _i += 6)
			{
				draw_rect_floored(_list[| _i], _list[| _i + 1], _list[| _i + 2], _list[| _i + 3], false, _list[| _i + 4]);
			}
		
			_list = debug_solids_sides
			_list_size = ds_list_size(_list);
		
			if (_list_size == 0)
			{
				draw_set_alpha(1.0);
				break;
			}
		
			for (var _i = 0; _i < _list_size; _i += 6)
			{
				draw_rect_floored(_list[| _i], _list[| _i + 1], _list[| _i + 2], _list[| _i + 3], false, _list[| _i + 4]);
			}
		
			_list = debug_solids_push;
			_list_size = ds_list_size(_list);
		
			if (_list_size == 0)
			{
				draw_set_alpha(1.0);
				break;
			}
		
			for (var _i = 0; _i < _list_size; _i += 10)
			{
				draw_rect_floored(_list[| _i], _list[| _i + 1], _list[| _i + 2], _list[| _i + 3], false, _list[| _i + 8]);
				draw_rect_floored(_list[| _i + 4], _list[| _i + 5], _list[| _i + 6], _list[| _i + 7], false, _list[| _i + 8]);
			}
		
			draw_set_alpha(1.0);
		
		break;
	}

	ds_list_clear(debug_tile_sensors);
	ds_list_clear(debug_interact);
	ds_list_clear(debug_solids);
	ds_list_clear(debug_solids_sides);
	ds_list_clear(debug_solids_push);

	if (global.debug_collision > 0)
	{
		with (obj_game_object)
		{
			draw_point_floored(x, y, c_white);
		}
	}
}