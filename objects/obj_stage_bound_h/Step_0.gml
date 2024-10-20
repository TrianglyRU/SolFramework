visible = global.debug_collision > 0;

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera = camera_get_data(_i);
	
	if (_camera == undefined)
	{
		continue;
	}
	
	var _half_width = camera_get_width(_i) / 2;
	var _half_height = camera_get_height(_i) / 2;
	var _x = _camera.pos_x + _half_width;
	
	if (_x < bbox_top || _x >= bbox_bottom)
	{
		continue;
	}
	
	var _y = _camera.pos_y + _half_height;
	var _y_prev = _camera.pos_y_prev + _half_height;
	
	if (image_xscale > 0 && _y >= y && _y_prev < y || image_xscale < 0 && _y < y && _y_prev >= y)
	{
		obj_rm_stage.bound_lower[_i] = vd_lower_limit;
		obj_rm_stage.bound_upper[_i] = vd_upper_limit;
		obj_rm_stage.bound_speed[_i] = vd_speed;
	}
}