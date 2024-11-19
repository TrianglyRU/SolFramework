/// @self obj_instance
/// @description Handles collision detection and response between the player and a solid object.
/// @param {Id.Instance} _player The player object instance.
/// @param {Enum.SOLIDOBJECT} _type The type of solid object.
/// @param {Enum.SOLIDATTACH} [_attach_type] Whether the player is allowed to land on this object or should they be reset (default is SOLIDATTACH.DEFAULT).
function obj_act_solid(_player, _type, _attach_type = SOLIDATTACH.DEFAULT)
{
	/// @method _attach_player()
	var _attach_player = function(_player, _obj, _attach_type, _distance)
	{
		solid_touch_flags[_player.player_index] = SOLIDCOLLISION.TOP;
		
		if (_attach_type == SOLIDATTACH.NONE)
		{
			return;
		}
		
		if (_attach_type == SOLIDATTACH.RESET_PLAYER)
		{
			_player.reset_substate();
		}
		
		_player.y -= (_distance + 1);
		_player.spd_ground	= _player.vel_x;
		_player.vel_y = 0;
		_player.angle = 0;
		_player.on_object = _obj;
		
		if (!_player.is_grounded)
		{
			_player.land();
		}
	}
	
	var _pid = _player.player_index;
	
	solid_touch_flags[_pid] = SOLIDCOLLISION.NONE;
	solid_push_flags[_pid] = false;
	
	var _prx = _player.solid_radius_x;
	var _pry = _player.solid_radius_y;
	var _orx = solid_radius_x;
	var _ory = solid_radius_y;
	
	if (_orx <= 0 || _ory <= 0 || _prx <= 0 || _pry <= 0 || _player.state >= PLAYERSTATE.LOCKED)
	{
		return;
	}
	
	var _ox_prev = floor(xprevious) + solid_offset_x;
	var _ox = floor(x) + solid_offset_x;
	var _oy = floor(y) + solid_offset_y;
	var _px = floor(_player.x);
	var _py = floor(_player.y);
	var _combined_width  = _orx + _prx + 1;
	var _combined_height = _ory + _pry;
	var _slope_offset = 0;
	var _grip_y = 4;
	var _ext_x = 0;
	
	// Handle height map for slope adjustment
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
	
	// Ensures the consistency of horizontal radisues between different checks
	if (global.better_solid_collision)
	{
		_ext_x = _prx;		
	}
	
	#region DEBUG
	
	if (global.debug_collision == 3)
	{
		var _ds_list = obj_framework.debug_solids;
		var _solid_colour = $00FFFF;
		
		if (ds_list_find_index(_ds_list, _player) == -1)
		{
			ds_list_add(_ds_list, _px - _prx, _py - _pry, _px + _prx, _py + _pry, _solid_colour, _player);
		}
		
		if (ds_list_find_index(_ds_list, id) == -1)
		{
			ds_list_add(_ds_list, _ox - _orx, _oy - _ory + _slope_offset, _ox + _orx, _oy + _ory + _slope_offset, _solid_colour, id);
		}
	}
	
	#endregion
	
	// Handle collision with the object if player is already on it
	if (_player.on_object == id)
	{	
		solid_touch_flags[_pid] = SOLIDCOLLISION.TOP;
		
		_player.x += _ox - _ox_prev;
		_player.y = _oy - _ory + _slope_offset - _pry - 1;
		_px = floor(_player.x);
		
		if (_type != SOLIDOBJECT.TOP)
		{
			var _relative_x = _px - _ox + _combined_width;
			
			if (_player.is_grounded && _relative_x >= 0 && _relative_x < _combined_width * 2)
			{
				return;
			}
		}
		else
		{
			var _relative_x = _px - _ox + _orx;
			
			if (_player.is_grounded && _relative_x >= -_ext_x && _relative_x < _orx * 2 + _ext_x)
			{
				return;
			}
		}
		
		solid_touch_flags[_pid] = SOLIDCOLLISION.NONE;
		_player.on_object = noone;
		
		return;
	}
	
	// Handle collision detection for non-platform objects
	if (_type != SOLIDOBJECT.TOP)
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
	
	// Handle collision detection for platform objects
	else if (_player.vel_y >= 0)
	{
		var _relative_x = _px - _ox + _orx;
		
		if (_relative_x < -_ext_x || _relative_x > _orx * 2 + _ext_x)
		{
			return;
		}
		
		var _y_clip = (_oy - _ory - _grip_y + _slope_offset) - (_py + _pry);
		
		if (_y_clip < -16 || _y_clip >= 0)
		{
			return;
		}
		
		_attach_player(_player, id, _attach_type, -_y_clip - _grip_y);
	}
}