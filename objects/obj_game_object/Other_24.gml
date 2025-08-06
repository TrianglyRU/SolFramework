/// Called in obj_game -> Begin Step -> CULLING
/// @description Culling

hitbox_allow = true;
		
if (cull_behaviour <= ACTIVEIF.OBJECTS_ACTIVE)
{
	return;
}

if (cull_is_respawned)
{
	// your advertisement here
	cull_is_respawned = false;
}

// Should we reset the object?
if (cull_reset_object)
{
	image_xscale = cull_scale_x;
	image_yscale = cull_scale_y;
	image_index = cull_image;
	sprite_index = cull_sprite;
	visible = cull_visible;
	depth = cull_depth;
	
	event_perform(ev_create, 0);
}

for (var _i = 0; _i < CAMERA_COUNT; _i++) 
{
	var _camera_data = camera_get_data(_i);
	if (_camera_data == undefined)
	{
		continue;
	}
	
	// Should be the same in obj_game -> Begin Step -> CULLING
	var _width = camera_get_width(_i) + CULLING_ADD_WIDTH + CULLING_ROUND_VALUE;
	var _height = camera_get_height(_i) + CULLING_ADD_HEIGHT + CULLING_ROUND_VALUE;
	
	var _left = _camera_data.coarse_x;
	var _right = _camera_data.coarse_x + _width;
	var _top = _camera_data.coarse_y;
	var _bottom = _camera_data.coarse_y + _height;
	
	var _process_cull = false;
	
	switch (cull_behaviour)
	{
		case ACTIVEIF.INBOUNDS:
		case ACTIVEIF.INBOUNDS_RESET:
		case ACTIVEIF.INBOUNDS_XY:
		case ACTIVEIF.INBOUNDS_XY_RESET:
			
			var _x = floor(x);
			var _y = floor(y);
			var _check_y = (cull_behaviour >= ACTIVEIF.INBOUNDS_XY);
			
			if (_x < _left || _x >= _right || (_y < _top || _y >= _bottom) && _check_y)
			{
				if (cull_behaviour == ACTIVEIF.INBOUNDS_RESET || cull_behaviour == ACTIVEIF.INBOUNDS_XY_RESET)
				{
					// If the object is subject to reset but its initial position is still within the area, make it "disappear"
					if (xstart >= _left && xstart < _right && (!_check_y || ystart >= _top && ystart < _bottom))
					{
						x = -127;
						y = -127;
					}
					else
					{
						_process_cull = true;
					}
				}
				else
				{
					_process_cull = true;
				}
			}

		break;
		
		case ACTIVEIF.INBOUNDS_DELETE:
			
			/// @feather ignore GM2044
			var _x = floor(x);
			var _y = floor(y);
			var _dist_y = (_y - camera_get_y(_i)) + CULLING_ROUND_VALUE;
			
			if (_x < _left || _x >= _right || _dist_y < 0 || _dist_y >= _height || _y >= _camera_data.bottom_bound)
			{
				_process_cull = true;
			}
		
		break;
	}
	
	// If failed to cull, exit completely
	if (!_process_cull)
	{
		return;
	}
}

if (cull_behaviour != ACTIVEIF.INBOUNDS_DELETE)
{
	cull_is_respawned = true;
	
	if (cull_behaviour == ACTIVEIF.INBOUNDS_RESET || cull_behaviour == ACTIVEIF.INBOUNDS_XY_RESET)
	{
		x = xstart;
		y = ystart;
		
		// Reset the object on respawn (trigger the Create Event)
		cull_reset_object = true;
	}
	
	instance_deactivate_object(id);
}
else
{
	instance_destroy();
}