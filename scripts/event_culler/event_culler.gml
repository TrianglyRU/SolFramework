function event_culler(_action = CULL_ACTION.PAUSE, _inst_id = id)
{
	new const_culler(_action, _inst_id);
}

function const_culler(_action, _inst_id) constructor
{
	if _inst_id.culler != noone
	{
		return;
	}
	
	enum CULL_ACTION
	{
		PAUSE,
		RESPAWN,
		DESTROY
	}
	
	inst_id = _inst_id;
	inst_id.culler = self;
	
	sprite_index_start = inst_id.sprite_index;
	image_xscale_start = inst_id.image_xscale;
	image_yscale_start = inst_id.image_yscale;
	image_index_start = inst_id.image_index;
	depth_start = inst_id.depth;
	visible_start = inst_id.visible;
	
	respawned = false; 
	action = _action;
	
	/// @function update()
	update = function()
	{
		if respawned
		{
			inst_id.image_xscale = image_xscale_start;
			inst_id.image_yscale = image_yscale_start;
			inst_id.image_index = image_index_start;
			inst_id.sprite_index = sprite_index_start;
			inst_id.visible = visible_start;
			inst_id.depth = depth_start;
			
			with inst_id
			{
				event_perform(ev_create, 0);
			}
			
			respawned = false;
		}
		
		var _x = floor(inst_id.x);
		var _y = floor(inst_id.y);

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
	
			switch action
			{
				case CULL_ACTION.DESTROY:
			
					var _dist_y = (_y - camera_get_y(_i)) + CULLING_ROUND_VALUE;
			
					if _x >= _left && _x < _right && _dist_y >= 0 && _dist_y < _height && _y < _camera_data.bottom_bound
					{
						// No action
						return;
					}
			
				break;
			
				case CULL_ACTION.PAUSE:
			
					if _x >= _left && _x < _right
					{
						// No action
						return;
					}
			
				break;
			
				case CULL_ACTION.RESPAWN:
		
					if _x >= _left && _x < _right || inst_id.xstart >= _left && inst_id.xstart < _right
					{
						// No action
						return;
					}
			
				break;
			}
		}

		switch action 
		{
			case CULL_ACTION.DESTROY:
				instance_destroy(inst_id);
			break;
		
			case CULL_ACTION.PAUSE:
				instance_deactivate_object(inst_id);
			break;
	
			case CULL_ACTION.RESPAWN:
		
				respawned = true;
				inst_id.x = inst_id.xstart;
				inst_id.y = inst_id.ystart;
				
				with inst_id
				{
					event_perform(ev_destroy, 0);
				}
				
				instance_deactivate_object(inst_id);
		
			break;
		}
	}
}