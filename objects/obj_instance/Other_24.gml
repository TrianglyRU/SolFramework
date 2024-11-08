/// Called in obj_framework -> Begin Step -> CULLING

interact_flag = true;
		
if (cull_behaviour <= CULLING.ACTIVE)
{
	return;
}

// Were we just respawned?
if (cull_respawn_flag)
{
	image_xscale = cull_scale_x;
	image_yscale = cull_scale_y;
	image_index = cull_image;
	sprite_index = cull_sprite;
	visible = cull_visible;
	depth = cull_depth;
	
	event_perform(ev_create, 0);
}

var _cull_action = CULLING.NONE;

for (var _i = 0; _i < CAMERA_COUNT; _i++) 
{
	var _camera_data = camera_get_data(_i);
	
	if (_camera_data == undefined)
	{
		continue;
	}
	
	// Clear flag
	_cull_action = CULLING.NONE;
	
	var _cull_width = camera_get_width(_i) + CULLING_ADD_WIDTH + CULLING_ROUND_VALUE;
	var _cull_height = camera_get_height(_i) + CULLING_ADD_HEIGHT + CULLING_ROUND_VALUE;
	
	switch (cull_behaviour)
	{
		case CULLING.SUSPEND:
		case CULLING.RESPAWN:
			
			var _x = floor(x);
			
			if (_x < _camera_data.coarse_x || _x >= _camera_data.coarse_x + _cull_width)
			{
				if (cull_behaviour == CULLING.SUSPEND)
				{
					_cull_action = cull_behaviour;
				}
				else if (xstart >= _camera_data.coarse_x && xstart < _camera_data.coarse_x + _cull_width)
				{
					x = -128;
					y = -128;
					visible = false;
				}
				else
				{
					_cull_action = cull_behaviour;
				}
			}
		
		break;
		
		case CULLING.ORIGINSUSPEND:
		case CULLING.ORIGINRESPAWN:
			
			if (xstart < _camera_data.coarse_x || xstart >= _camera_data.coarse_x + _cull_width)
			{
				_cull_action = cull_behaviour;
			}
		
		break;
		
		case CULLING.REMOVE:
			
			/// @feather ignore GM2044
			var _x = floor(x);
			var _y = floor(y);
			var _bound_x_delete = _camera_data.coarse_x;
			
			var _dist_y = (_y - camera_get_y(_i)) + CULLING_ROUND_VALUE;
			
			if (_x < _bound_x_delete || _x >= _bound_x_delete + _cull_width || _dist_y < 0 || _dist_y >= _cull_height || _y >= _camera_data.bound_lower)
			{
				_cull_action = cull_behaviour;
			}
		
		break;
	}
	
	// If no flag has been set, do not continue
	if (_cull_action == CULLING.NONE)
	{
		return;
	}
}

if (_cull_action != CULLING.REMOVE)
{
	// Trigger Create Event next on respawn
	if (cull_behaviour >= CULLING.RESPAWN)
	{
		x = xstart;
		y = ystart;
	
		cull_respawn_flag = true;
	}
	
	instance_deactivate_object(id);
}
else
{
	instance_destroy();
}