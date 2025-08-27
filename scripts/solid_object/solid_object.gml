/// @self g_object_solid
/// @description Handles collision detection and response between the player and a solid object.
function solid_object(_player, _type, _bbleft = bbox_left, _bbtop = bbox_top, _bbright = bbox_right, _bbbottom = bbox_bottom)
{
	var _p = _player.player_index;
	
	solid_touch[_p] = SOLID_TOUCH.NONE;
	solid_push[_p] = false;
	
	if _player.state >= PLAYERSTATE.LOCKED
	{
		return;
	}
		
	var _ox_prev = floor(xprevious);
	var _ox = floor(x);
	var _oy = floor(y);
	var _px = floor(_player.x);
	var _py = floor(_player.y);
	var _prx = _player.solid_radius_x;
	var _pry = _player.solid_radius_y;
		
	var _combined_width  = _radius_x + _prx + 1;
	var _combined_height = _radius_y + _pry;
	var _slope_offset = 0;
	var _grip_y = 4;
	var _ext_x = 0;
	
	// Handle height map for slope adjustment
	/*
	if array_length(solid_height_map) > 0
	{
		var _index;
		
		if (image_xscale >= 0)
		{
			_index = _px - _ox + _orx;
		}
		else
		{
			_index = _ox - _px + _orx;
		}
		
		_index = clamp(_index, 0, array_length(solid_height_map) - 1);
		_slope_offset = (_ory - solid_height_map[_index]) * image_yscale;	
	}
	*/
		
	// Ensures the consistency of horizontal radisues between different checks
	if global.better_solid_collision
	{
		_ext_x = _prx;		
	}
		
	if _player.on_object == id
	{
		solid_touch[_p] = SOLID_TOUCH.TOP;
			
		_player.x += _ox - _ox_prev;
		_player.y = _oy - _radius_y + _slope_offset - _pry - 1;
			
		var _player_x = floor(_player.x);
		var _obj_left = floor(_bbleft);
		var _obj_right = floor(_bbright);
			
		if _type < SOLID_TYPE.TOP
		{
			if !_player.is_grounded || _player_x + _prx < _obj_left || _player_x - _prx >= _obj_right
			{
				_player.on_object = noone;
			}
			else
			{
				return;
			}
		}
		else
		{
			if !_player.is_grounded || _player_x < _obj_left || _player_x >= _obj_right
			{
				_player.on_object = noone;
			}
			else
			{
				return;
			}
		}
			
		solid_touch[_p] = SOLID_TOUCH.NONE;
	}
	else if _type < SOLID_TYPE.TOP
	{
		var _s3_method = global.player_physics >= PHYSICS.S3;
		var _x_dist = _px - _ox + _combined_width;
		var _y_dist = _py - _oy + _combined_height - _slope_offset + _grip_y;
		
		if (_x_dist < 0 || _x_dist > _combined_width * 2 || _y_dist < 0 || _y_dist > _combined_height * 2)
		{
			obj_clear_solid_push(_player);
			return;
		}
		
		var _x_clip = _px < _ox ? _x_dist : (_x_dist - _combined_width * 2);
		var _y_clip = _py < _oy ? _y_dist : (_y_dist - _combined_height * 2 - _grip_y);
		
		// VERTICAL COLLISION
		
		if (abs(_x_clip) >= abs(_y_clip) || _s3_method && abs(_y_clip) <= _grip_y)
		{
			if (_y_clip < 0)
			{
				if (_type == SOLIDOBJECT.ITEMBOX || _type == SOLIDOBJECT.SIDES)
				{
					// Fallthrough to horizontal collision
				}
				else if (_player.vel_y == 0 && _player.is_grounded)
				{
					if (abs(_x_clip) >= 16)
					{
						_player.kill();
						return;
					}
					
					// If not crushed, fallthrough to horizontal collision
				}
				else 
				{
					if (_player.vel_y < 0)
					{
						if (_s3_method && !_player.is_grounded)
						{
							_player.spd_ground = 0;
						}
						
						_player.y -= _y_clip;
						_player.vel_y = 0;
					}
					
					solid_touch_flags[_pid] = SOLIDCOLLISION.BOTTOM;
					
					// Do not run horizontal collision
					return;							
				}
			}
			else
			{
				if (_y_clip < 16 && _type != SOLIDOBJECT.SIDES)
				{
					if (_player.vel_y >= 0)
					{
						var _relative_x = _px - _ox + _orx;
						if (_relative_x >= 0 - _ext_x && _relative_x < _orx * 2 + _ext_x)
						{
							_attach_player(_player, id, _attach_type, _y_clip - _grip_y);
						}
					}
				}
				else
				{
					obj_clear_solid_push(_player);
				}
				
				// Do not run horizontal collision
				return;	
			}
		}
		
		// HORIZONTAL COLLISION

		if (!_s3_method && abs(_y_clip) <= _grip_y)
		{
			obj_clear_solid_push(_player);
			return;
		}

		solid_touch_flags[_pid] = _px < _ox ? SOLIDCOLLISION.LEFT : SOLIDCOLLISION.RIGHT;
		
		if (_player.is_grounded)
		{
			_player.set_push_anim_by = id;
		}
		else
		{
			_player.set_push_anim_by = noone;
		}
		
		if (_x_clip != 0 && sign(_x_clip) == sign(_player.vel_x))
		{
			_player.spd_ground = 0;
			_player.vel_x = 0;
			
			solid_push_flags[_pid] = _player.is_grounded;
		}
		
		_player.x -= _x_clip;
	}
	else if _player.vel_y >= 0
	{
		var _player_x = floor(_player.x);
		var _obj_left = floor(_bbleft);
		var _obj_right = floor(_bbright);
			
		if _player_x >= _obj_left && _player_x < _obj_right
		{
			_attach_to_solid(_type, _player, id);
		}
	}
}

/// @self g_object_solid
function _attach_to_solid(_type, _player, _obj)
{
	solid_touch[_player.player_index] = SOLID_TOUCH.TOP;
	
	if (_type == SOLID_TYPE.FULL_RESET || _type == SOLID_TYPE.TOP_RESET)
	{
		_player.reset_substate();
	}
	
	_player.y = _obj.bbox_top - _player.radius_y;
	_player.spd_ground	= _player.vel_x;
	_player.vel_y = 0;
	_player.angle = 0;
	_player.on_object = _obj;
	
	if !_player.is_grounded
	{
		player_land(_player);
	}
}