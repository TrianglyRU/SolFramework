/// @description					Checks if the instance is visible or drawn within any of the current view boundaries.
/// @param {ID.Instance} _inst_id	The instance to check (default is the calling instance)
/// @returns {Bool}
function instance_is_drawn(_inst_id = id)
{
	if !instance_exists(_inst_id) || _inst_id.sprite_index < 0 || !_inst_id.visible
	{
		return false;
	}
	
	for (var _i = 0; _i < CAMERA_COUNT; _i++)
	{
		if !view_visible[_i]
		{
			continue;
		}
		
		var _cx = camera_get_x(_i);
		var _cw = camera_get_width(_i);
		
		var _x = _inst_id.x;
		var _y = _inst_id.y;
		var _w = _inst_id.sprite_width;
		var _h = _inst_id.sprite_height;
		
		if _x + _w >= _cx && _x - _w < _cx + _cw
		{
			var _cy = camera_get_y(_i);
			var _ch = camera_get_height(_i);
			
			if _y + _h >= _cy && _y - _h < _cy + _ch
			{
				return true;
			}
		}
	}

	return false;
}