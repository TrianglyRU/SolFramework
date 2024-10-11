var _do_update = obj_framework.state != FWSTATE.PAUSED;

if (water_enabled)
{
	if (_do_update)
	{
		switch (room)
		{
			case rm_stage_tsz2:
				water_level = math_oscillate_y(water_level_init, obj_framework.frame_counter * ANGLE_INCREMENT, 10, 1, 90);
			break;
		}
	}
	
	obj_framework.distortion_bound = water_level;
	obj_framework.palette_bound = water_level;
	obj_framework.bg_perspective_data[0] = water_level;
}

if (!_do_update)
{
	exit;
}

// Palette Rotation
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
	if (bound_end != undefined)
	{
		var _left_end_bound = bound_end - camera_get_width(_i) - 256;
		
		if (_view_x >= _left_end_bound + 256)
		{
			bound_left[_i] = _left_end_bound + 256;
		}
		else if (_view_x >= _left_end_bound)
		{
			if (instance_exists(obj_capsule) && bound_left[_i] < _view_x)
			{
				bound_left[_i] = _view_x;
			}
			else if (bound_left[_i] < _left_end_bound)
			{
				bound_left[_i] = _left_end_bound;
			}
		}
		
		if (bound_right[_i] > bound_end)
		{
			bound_right[_i] = bound_end;
		}
	}
	
	if (bound_speed[_i] < 2)
	{
		bound_speed[_i] = 2;
	}
	
	var _left_bound = bound_left[_i];
	var _right_bound = bound_right[_i];
	var _top_bound = bound_upper[_i];
	var _bottom_bound = bound_lower[_i];
	var _bound_speed = bound_speed[_i];
	
	// Left camera bound
	if (_camera_data.bound_left < _left_bound)
	{
		if (_view_x >= _left_bound)
		{
			_camera_data.bound_left = _left_bound;
		}
		else
		{
			_camera_data.bound_left = max(_view_x, _camera_data.bound_left);
			_camera_data.bound_left = min(_camera_data.bound_left + _bound_speed, _left_bound);
		}
	}
	else if (_camera_data.bound_left > _left_bound)
	{
		_camera_data.bound_left = max(_left_bound, _camera_data.bound_left - _bound_speed);
	}
	
	// Right camera bound
	if (_camera_data.bound_right < _right_bound)
	{
		_camera_data.bound_right = min(_camera_data.bound_right + _bound_speed, _right_bound);
	}
	else if (_camera_data.bound_right > _right_bound)
	{
		if (_view_x + _width <= _right_bound)
		{
			_camera_data.bound_right = _right_bound;
		}
		else
		{
			_camera_data.bound_right = min(_camera_data.bound_right, _view_x + _width);
			_camera_data.bound_right = max(_right_bound, _camera_data.bound_right - _bound_speed);
		}
	}
	
	// Upper camera bound
	if (_camera_data.bound_upper < _top_bound)
	{
		if _view_y >= _top_bound
		{
			_camera_data.bound_upper = _top_bound;
		}
		else
		{
			_camera_data.bound_upper = max(_camera_data.bound_upper, _view_y);
			_camera_data.bound_upper = min(_camera_data.bound_upper + _bound_speed, _top_bound);
		}
	}
	else if (_camera_data.bound_upper > _top_bound)
	{
		_camera_data.bound_upper = max(_top_bound, _camera_data.bound_upper - _bound_speed);
	}
	
	// Lower camera bound
	if (_camera_data.bound_lower < _bottom_bound)
	{
		_camera_data.bound_lower = min(_camera_data.bound_lower + _bound_speed, _bottom_bound);
	}
	else if _camera_data.bound_lower > _bottom_bound
	{
		if (_view_y + _height <= _bottom_bound)
		{
			_camera_data.bound_lower = _bottom_bound;
		}
		else
		{
			_camera_data.bound_lower = min(_view_y + _height, _camera_data.bound_lower);
			_camera_data.bound_lower = max(_bottom_bound, _camera_data.bound_lower - _bound_speed);
		}
	}
}