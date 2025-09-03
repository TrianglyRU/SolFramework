/// @description Active Culling
/// This is a user event because of a posibillity of it being called at various points of game loop

// Restore every game object that was deactivated
var _list_size = ds_list_size(cull_game_paused_list);

if _list_size > 0
{
	for (var _i = _list_size - 1; _i >= 0; _i--)
	{
		instance_activate_object(cull_game_paused_list[| _i]);
	}
	
	ds_list_clear(cull_game_paused_list);
	
	instance_activate_object(obj_room);
}

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera_data = camera_get_data(_i);
	
	if _camera_data == undefined
	{
		continue;
	}
	
	_camera_data.coarse_x = (camera_get_x(_i) - CULLING_ROUND_VALUE) & -CULLING_ROUND_VALUE;
	_camera_data.coarse_y = (camera_get_y(_i) - CULLING_ROUND_VALUE) & -CULLING_ROUND_VALUE;
	
	if _camera_data.coarse_x_last != _camera_data.coarse_x || _camera_data.coarse_y_last != _camera_data.coarse_y
	{
		_camera_data.coarse_x_last = _camera_data.coarse_x;
		_camera_data.coarse_y_last = _camera_data.coarse_y;
		
		// Should be the same in obj_game_object -> User Event 14
		var _width = camera_get_width(_i) + CULLING_ROUND_VALUE + CULLING_ADD_WIDTH;
		var _height = camera_get_height(_i) + CULLING_ROUND_VALUE + CULLING_ADD_HEIGHT;
		
		// Activate all instances whose *bounding boxes* overlap the area
		instance_activate_region(_camera_data.coarse_x, _camera_data.coarse_y, _width - 1, _height - 1, true);
	}
}

// Cull game objects by their *position* (this will also cancel "false" activations by instance_activate_region)
with obj_object
{
	event_user(15);
}