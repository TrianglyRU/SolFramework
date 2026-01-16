visible = player_get(0).state == PLAYER_STATE.DEBUG_MODE;

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera = camera_get_data(_i);
	
	if _camera == undefined
	{
		continue;
	}
	
	var _w = camera_get_width(_i);
	var _h = camera_get_height(_i);
	
	var _x = _camera.raw_x + _w * 0.5;
	var _y = _camera.raw_y + _h * 0.5;
	
	if point_in_rectangle(_x, _y, bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1)
	{
		if image_yscale >= 0
		{
			obj_rm_stage.bottom_bound[_i] = max(bbox_bottom - 8, _h);
			
			if iv_speed == 0
			{
				_camera.bottom_bound = obj_rm_stage.bottom_bound[_i];
			}
			else
			{
				obj_rm_stage.bound_speed[_i] = iv_speed;
			}
		}
		else
		{
			obj_rm_stage.top_bound[_i] = min(bbox_top + 8, room_height - _h);
			
			if iv_speed == 0
			{
				_camera.top_bound = obj_rm_stage.top_bound[_i];
			}
			else
			{
				obj_rm_stage.bound_speed[_i] = iv_speed;
			}
		}
	}
}