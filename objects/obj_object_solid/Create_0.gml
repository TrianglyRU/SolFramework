// Inherit the parent event
event_inherited();

enum SOLID_TYPE
{
	ITEMBOX,
	SIDES,
	FULL,
	FULL_RESET,
	FULL_NO_LAND,
	TOP,
	TOP_RESET,
	TOP_NO_LAND
}

enum SOLID_TOUCH
{
    NONE,
	TOP,
	BOTTOM,
	LEFT,
	RIGHT
}

/// @self obj_object_solid
solid_object = function(_player, _type)
{
	var _p = _player.player_index;
	
	solid_touch[_p] = SOLID_TOUCH.NONE;
	solid_push[_p] = false;
	
	if _player.state >= PLAYER_STATE.DEFAULT_LOCKED
	{
		return;
	}
	
	var _vanilla_collision = !global.better_solid_collision;
	
	var _ox = floor(x);
	var _oy = floor(y);
	var _oleft = floor(bbox_left);
	var _otop = floor(bbox_top);
	var _oright = floor(bbox_right) - 1;
	var _obottom = floor(bbox_bottom) - 1;
	
	var _px = floor(_player.x);
	var _py = floor(_player.y);
	var _prx = _player.radius_wall;
	var _pry = _player.radius_y;
	var _pleft = _px - _prx;
	var _pright = _px + _prx - 1;
	var _ptop = _py - _pry;
	var _pbottom = _py + _pry - 1;
	
	var _grip_y = _type == SOLID_TYPE.ITEMBOX ? 0 : 4;
	var _slope_offset = 0;
	
	// Get slope offset
	if array_length(solid_offsets) > 0
	{
		var _index;
		var _relative_x = _px - _oleft;
		
		if image_xscale >= 0
		{
			_index = _relative_x;
		}
		else
		{
			_index = _oright - _oleft - _relative_x;
		}
		
		_slope_offset = solid_offsets[clamp(_index, 0, array_length(solid_offsets) - 1)];
	}
	
	if _player.on_object == id
	{
		_player.x += _ox - floor(xprevious);
		_player.y = _otop - _pry + _slope_offset;
		
		var _new_px = floor(_player.x);
		var _new_pleft = _new_px - _prx;
		var _new_pright = _new_px + _prx - 1;
		
		if _type < SOLID_TYPE.TOP
		{
			if !_player.is_grounded || _new_pright < _oleft || _new_pleft > _oright
			{
				_player.on_object = noone;
			}
			else
			{
				solid_touch[_p] = SOLID_TOUCH.TOP;
			}
		}
		else
		{
			if !_player.is_grounded || _new_px < _oleft || _new_px > _oright
			{
				_player.on_object = noone;
			}
			else
			{
				solid_touch[_p] = SOLID_TOUCH.TOP;
			}
		}
		
		return;
	}
	
	// Besides slope offset, assume the player is grip_y pixels lower than they actually are	
	var _y_offset = -_slope_offset + _grip_y;
	
	var _ptop_off = _ptop + _y_offset;
	var _pbottom_off = _pbottom + _y_offset;
	
	if _type < SOLID_TYPE.TOP
	{
		if !rectangle_in_rectangle(_pleft, _ptop_off, _pright, _pbottom_off, _oleft - 1, _otop, _oright + 1, _obottom)
		{
			_player.clear_solid_push(); return;
		}
		
		var _x_clip = _px < _ox ? _pright - _oleft + 1 : _pleft - _oright - 1;
		var _y_clip = _py < _oy ? _pbottom_off - _otop + 1 : _ptop_off - _obottom - 1 - _grip_y;
		
		var _can_collide_v = abs(_x_clip) >= abs(_y_clip);
		var _can_collide_h = abs(_y_clip) > _grip_y;
		
		// VERTICAL COLLISION
		
		// Regular
		if _type != SOLID_TYPE.ITEMBOX
		{
			var _s3_method = global.player_physics >= PHYSICS.S3;
			
			if _s3_method
			{
				_can_collide_v |= !_can_collide_h;
				_can_collide_h = true;
			}
			
			if _can_collide_v
			{
				// From below
				if _y_clip < 0
				{
					if _type == SOLID_TYPE.SIDES
					{
						// Try horizontal collision
					}
					else if _player.vel_y == 0 && _player.is_grounded
					{
						if abs(_x_clip) >= 16
						{
							_player.kill(); return;
						}
					
						// If not crushed, try horizontal collision
					}
					else
					{
						if _player.vel_y < 0
						{
							if _s3_method && !_player.is_grounded
							{
								_player.spd_ground = 0;
							}
						
							_player.y -= _y_clip;
							_player.vel_y = 0;
						}
					
						solid_touch[_p] = SOLID_TOUCH.BOTTOM;
						
						// Do not run horizontal collision
						return;							
					}
				}
				
				// From above
				else
				{
					if _y_clip < 16 && _type != SOLID_TYPE.SIDES
					{
						if _player.vel_y >= 0
						{
							if  _vanilla_collision && _px >= _oleft && _px <= _oright
							|| !_vanilla_collision && _pright >= _oleft && _pleft <= _oright
							{
								attach_player(_type, _player, _otop + _slope_offset);
							}
						}
					}
					else
					{
						_player.clear_solid_push();
					}
					
					// Do not run horizontal collision
					return;	
				}
			}
		}
		
		// Item Box
		else
		{
			if _y_clip < 16 && _px >= _oleft - 4 && _px <= _oright + 4
			{
				attach_player(_type, _player, _otop + _slope_offset);
				
				// Do not run horizontal collision
				return;
			}
			
			// Collide horizontally
			_can_collide_h = true;
		}
		
		// HORIZONTAL COLLISION
		
		if !_can_collide_h
		{
			_player.clear_solid_push(); return;
		}
		
		solid_touch[_p] = _px < _ox ? SOLID_TOUCH.LEFT : SOLID_TOUCH.RIGHT;
		
		if _player.is_grounded
		{
			_player.set_push_anim_by = id;
		}
		else
		{
			_player.set_push_anim_by = noone;
		}
		
		if _x_clip != 0 && sign(_x_clip) == sign(_player.vel_x)
		{
			_player.spd_ground = 0;
			_player.vel_x = 0;
			
			solid_push[_p] = _player.is_grounded;
		}
		
		_player.x -= _x_clip;
	}
	else if _player.vel_y >= 0
	{
		if  _vanilla_collision && _px >= _oleft && _px <= _oright
		|| !_vanilla_collision && _pright >= _oleft && _pleft <= _oright
		{
			var _y_clip = _otop - 1 - _pbottom_off;
			
			if _y_clip >= -16 && _y_clip <= 0
			{
				attach_player(_type, _player, _otop + _slope_offset);
			}
		}
	}
}

/// @self obj_object_solid
attach_player = function(_type, _player, _bbtop)
{
	solid_touch[_player.player_index] = SOLID_TOUCH.TOP;
	
	if _type == SOLID_TYPE.FULL_NO_LAND || _type == SOLID_TYPE.TOP_NO_LAND
	{
		return;
	}
	
	if _type == SOLID_TYPE.FULL_RESET || _type == SOLID_TYPE.TOP_RESET
	{
		_player.reset_substate();
	}
	
	_player.y = _bbtop - _player.radius_y;
	_player.spd_ground	= _player.vel_x;
	_player.vel_y = 0;
	_player.angle = 0;
	_player.on_object = id;
	
	if !_player.is_grounded
	{
		_player.land();
	}
}

solid_offsets = [];
solid_balance = true;
solid_push = array_create(PLAYER_MAX_COUNT, false);
solid_touch = array_create(PLAYER_MAX_COUNT, SOLID_TOUCH.NONE);