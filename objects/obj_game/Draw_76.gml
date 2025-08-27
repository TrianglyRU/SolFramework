/// @description Draw Objects While Paused
if (room == rm_startup || state == GAME_STATE.NORMAL)
{
	return;
}

// Activate objects within existing views to draw them
for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera = view_camera[_i];
	if (_camera != -1)
	{
		var _x = camera_get_view_x(_camera);
		var _y = camera_get_view_y(_camera);
		var _w = camera_get_view_width(_camera);
		var _h = camera_get_view_height(_camera);
		
		instance_activate_region(_x, _y, _w, _h, true);
	}
}

// Activate objects near (0,0) that may appear in view as well
instance_activate_region(-16, -16, 32, 32, true);