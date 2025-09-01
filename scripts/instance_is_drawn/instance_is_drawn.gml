/// @self obj_game_object
/// @description Checks if the object is visible or drawn within any of the current view boundaries.
/// @returns {Bool}
function instance_is_drawn()
{
	if sprite_index < 0 || !visible
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
		
		if floor(x) + sprite_width >= _cx && floor(x) - sprite_width < _cx + _cw
		{
			var _cy = camera_get_y(_i);
			var _ch = camera_get_height(_i);
			
			if floor(y) + sprite_height >= _cy && floor(y) - sprite_height < _cy + _ch
			{
				return true;
			}
		}
	}

	return false;
}