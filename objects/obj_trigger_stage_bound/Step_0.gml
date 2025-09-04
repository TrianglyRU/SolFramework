for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera = camera_get_data(_i);
	
	if _camera == undefined
	{
		continue;
	}
	
	var _width = camera_get_width(_i);
	var _height = camera_get_height(_i);
	
	var _x = _camera.pos_x + _width * 0.5;
	var _y = _camera.pos_y + _height * 0.5;
	
	if point_in_rectangle(_x, _y, bbox_left, bbox_top, bbox_right, bbox_bottom)
	{
		obj_rm_stage.top_bound[_i] = min(vd_top_bound, room_height - _height);
		obj_rm_stage.bottom_bound[_i] = max(vd_bottom_bound, _height);
		obj_rm_stage.bound_speed[_i] = vd_scroll_speed;
	}
}