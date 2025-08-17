if (water_enabled)
{
	switch (room)
	{
		case rm_stage_dwz0: break;
		default:
			water_level = math_oscillate_y(water_level_init, obj_game.frame_counter * ANGLE_INCREMENT, 10, 1, 90);
	}
	
	set_water_effects_bound();
}

// Palette rotation
scr_stage_palette_rotation();

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera_data = camera_get_data(_i);
	if (_camera_data == undefined || !_camera_data.allow_movement)
	{
		continue;
	}
	
	var _view_x = camera_get_x(_i);
	var _view_y = camera_get_y(_i);
	var _width = camera_get_width(_i);
	var _height = camera_get_height(_i);
	
	// Level end bounds
	if (end_bound != undefined)
	{
		var _left_end_bound = end_bound - camera_get_width(_i) - 256;
		if (_view_x >= _left_end_bound + 256)
		{
			left_bound[_i] = _left_end_bound + 256;
		}
		else if (_view_x >= _left_end_bound)
		{
			if (instance_exists(obj_capsule) && left_bound[_i] < _view_x)
			{
				left_bound[_i] = _view_x;
			}
			else if (left_bound[_i] < _left_end_bound)
			{
				left_bound[_i] = _left_end_bound;
			}
		}
		
		if (right_bound[_i] > end_bound)
		{
			right_bound[_i] = end_bound;
		}
	}
	
	if (bound_speed[_i] < 2)
	{
		bound_speed[_i] = 2;
	}
	
	var _left_bound = left_bound[_i];
	var _right_bound = right_bound[_i];
	var _top_bound = top_bound[_i];
	var _bottom_bound = bottom_bound[_i];
	var _bound_speed = bound_speed[_i];
	
	// Left camera bound
	if (_camera_data.left_bound < _left_bound)
	{
		if (_view_x >= _left_bound)
		{
			_camera_data.left_bound = _left_bound;
		}
		else
		{
			_camera_data.left_bound = max(_view_x, _camera_data.left_bound);
			_camera_data.left_bound = min(_camera_data.left_bound + _bound_speed, _left_bound);
		}
	}
	else if (_camera_data.left_bound > _left_bound)
	{
		_camera_data.left_bound = max(_left_bound, _camera_data.left_bound - _bound_speed);
	}
	
	// Right camera bound
	if (_camera_data.right_bound < _right_bound)
	{
		_camera_data.right_bound = min(_camera_data.right_bound + _bound_speed, _right_bound);
	}
	else if (_camera_data.right_bound > _right_bound)
	{
		if (_view_x + _width <= _right_bound)
		{
			_camera_data.right_bound = _right_bound;
		}
		else
		{
			_camera_data.right_bound = min(_camera_data.right_bound, _view_x + _width);
			_camera_data.right_bound = max(_right_bound, _camera_data.right_bound - _bound_speed);
		}
	}
	
	// Top camera bound
	if (_camera_data.top_bound < _top_bound)
	{
		if _view_y >= _top_bound
		{
			_camera_data.top_bound = _top_bound;
		}
		else
		{
			_camera_data.top_bound = max(_camera_data.top_bound, _view_y);
			_camera_data.top_bound = min(_camera_data.top_bound + _bound_speed, _top_bound);
		}
	}
	else if (_camera_data.top_bound > _top_bound)
	{
		_camera_data.top_bound = max(_top_bound, _camera_data.top_bound - _bound_speed);
	}
	
	// Bottom camera bound
	if (_camera_data.bottom_bound < _bottom_bound)
	{
		_camera_data.bottom_bound = min(_camera_data.bottom_bound + _bound_speed, _bottom_bound);
	}
	else if _camera_data.bottom_bound > _bottom_bound
	{
		if (_view_y + _height <= _bottom_bound)
		{
			_camera_data.bottom_bound = _bottom_bound;
		}
		else
		{
			_camera_data.bottom_bound = min(_view_y + _height, _camera_data.bottom_bound);
			_camera_data.bottom_bound = max(_bottom_bound, _camera_data.bottom_bound - _bound_speed);
		}
	}
}