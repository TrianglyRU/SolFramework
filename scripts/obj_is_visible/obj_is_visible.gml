/// @self g_object
/// @description Checks if the object is visible within any of the current view boundaries.
/// @returns {Bool}
function obj_is_visible()
{
	if (sprite_index < 0)
	{
		return false;
	}
	
	for (var _i = 0; _i < CAMERA_COUNT; _i++)
	{
		if (!view_visible[_i])
		{
			continue;
		}
		
		var _cx = camera_get_x(_i);
		var _cw = camera_get_width(_i);
		
		if (floor(x) + cull_width >= _cx && floor(x) - cull_width < _cx + _cw)
		{
			var _cy = camera_get_y(_i);
			var _ch = camera_get_height(_i);
			
			if (floor(y) + cull_height >= _cy && floor(y) - cull_height < _cy + _ch)
			{
				return true;
			}
		}
	}

	return false;
}