/// @description Culling
/// Called in obj_game -> Begin Step -> CULLING. Override if not required!

if outside_respawned
{
	image_xscale = image_xscale_start;
	image_yscale = image_yscale_start;
	image_index = image_index_start;
	sprite_index = sprite_index_start;
	visible = visible_start;
	depth = depth_start;
	
	event_perform(ev_create, 0);
}

var _x = floor(x);
var _y = floor(y);

for (var _i = 0; _i < CAMERA_COUNT; _i++) 
{
	var _camera_data = camera_get_data(_i);
	if _camera_data == undefined
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
	
	switch outside_action
	{
		case OUTSIDE_ACTION.DESTROY:
			
			var _dist_y = (_y - camera_get_y(_i)) + CULLING_ROUND_VALUE;
			
			if _x >= _left && _x < _right && _dist_y >= 0 && _dist_y < _height && _y < _camera_data.bottom_bound
			{
				// No action
				return;
			}
			
			break;
			
		case OUTSIDE_ACTION.PAUSE:
			
			if _x >= _left && _x < _right
			{
				// No action
				return;
			}
			
			break;
			
		case OUTSIDE_ACTION.RESPAWN:
		
			if _x >= _left && _x < _right || xstart >= _left && xstart < _right
			{
				// No action
				return;
			}
			
			break;
	}
}

switch outside_action 
{
	case OUTSIDE_ACTION.DESTROY:
		instance_destroy();
		break;
		
	case OUTSIDE_ACTION.PAUSE:
		instance_deactivate_object(id);
		break;
	
	case OUTSIDE_ACTION.RESPAWN:
		
		outside_respawned = true;
		x = xstart;
		y = ystart;
		
		event_perform(ev_destroy, 0);
		instance_deactivate_object(id);
}