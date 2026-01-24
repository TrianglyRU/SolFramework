visible = player_get(0).state == PLAYER_STATE.DEBUG_MODE;

if !instance_exists(obj_water)
{
	return;
}

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
		
	if !point_in_rectangle(_x, _y, bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1)
	{
		continue;
	}
	
	if iv_velocity == 0
	{
		obj_water.current_level = iv_target_level;
		obj_water.target_level = iv_target_level;
	}
	else
	{
		obj_water.target_level = iv_target_level;
		obj_water.velocity = abs(iv_velocity);
	}
}