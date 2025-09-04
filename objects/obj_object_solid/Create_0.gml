// Inherit the parent event
event_inherited();

enum SOLID_TYPE
{
	ITEM_BOX,
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

/// @param {Id.Instance} _player		The player object instance.
/// @param {Enum.SOLID_TYPE|Real} _type	The type of solid object.
/// @param {Real} [_bbleft]				The maximum left position of the bounding box (optional, default is bbox_left).
/// @param {Real} [_bbtop]				The maximum top position of the bounding box (optional, default is bbox_top).
/// @param {Real} [_bbright]			The maximum right position of the bounding box (optional, default is bbox_right).
/// @param {Real} [_bbbottom]			The maximum bottom position of the bounding box (optional, default is bbox_bottom).
m_solid_object = function(_player, _type, _bbleft = bbox_left, _bbtop = bbox_top, _bbright = bbox_right, _bbbottom = bbox_bottom)
{
	var _p = _player.player_index;
	
	solid_touch[_p] = SOLID_TOUCH.NONE;
	solid_push[_p] = false;
	
	if _player.state >= PLAYER_STATE.DEFAULT_LOCKED
	{
		return;
	}
	
	_bbleft = floor(_bbleft);
	_bbtop = floor(_bbtop);
	_bbright = floor(_bbright);
	_bbbottom = floor(_bbbottom);
	
	var _slope_offset = 0;
	var _grip_y = 4;
	var _ext_x = 0;
	
	var _ox_prev = floor(xprevious);
	var _ox = floor(x);
	var _oy = floor(y);
	var _px = floor(_player.x);
	var _py = floor(_player.y);
	var _prx = _player.radius_x_normal + 1;
	var _pry = _player.solid_radius_y;
	
	// Get slope offset
	if array_length(solid_offsets) > 0
	{
		var _index;
		
		if image_xscale >= 0
		{
			_index = _px - _bbleft;
		}
		else
		{
			_index = _bbright - _px - _bbleft;
		}
		
		_slope_offset = solid_offsets[clamp(_index, 0, array_length(solid_offsets) - 1)];
	}
	
	// Ensures the consistency of horizontal radisues between different checks
	if global.better_solid_collision
	{
		// _ext_x = _prx;		
	}
	
	if _player.on_object == id
	{
		_player.x += _ox - _ox_prev;
		_player.y = _bbtop - _pry - 1 + _slope_offset;
		
		var _new_px = floor(_player.x);
		
		if _type < SOLID_TYPE.TOP
		{
			if !_player.is_grounded || _new_px + _prx <= _bbleft || _new_px - _prx >= _bbright
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
			if !_player.is_grounded || _new_px + _ext_x <= _bbleft - 1 || _new_px - _ext_x >= _bbright
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
	
	// Assume player is 4px lower than they actually are
	var _py2 = _py + _grip_y - _slope_offset;
	
	if _type < SOLID_TYPE.TOP
	{	
		if !point_in_rectangle(_px, _py2, _bbleft - 1 - _prx, _bbtop + 1 - _pry, _bbright + _prx, _bbbottom - 1 + _pry)
		{
			_player.m_clear_solid_push(id);
			return;
		}
		
		var _ptop = _py2 - _pry;
		var _pbottom = _py2 + _pry;
		var _pleft = _px - _prx;
		var _pright = _px + _prx;
		
		var _x_clip = _px < _ox ? _pright - _bbleft + 1 : _pleft - _bbright;
		var _y_clip = _py < _oy ? _pbottom - _bbtop + 1 : _ptop - _bbbottom - _grip_y;
		
		var _s3_method = global.player_physics >= PHYSICS.S3;
		
		// VERTICAL COLLISION
		
		if abs(_x_clip) >= abs(_y_clip) || _s3_method && abs(_y_clip) <= _grip_y
		{
			if _y_clip < 0
			{
				if _type == SOLID_TYPE.ITEM_BOX || _type == SOLID_TYPE.SIDES
				{
					// Fallthrough to horizontal collision
				}
				else if _player.vel_y == 0 && _player.is_grounded
				{
					if abs(_x_clip) >= 16
					{
						_player.m_kill();
						return;
					}
					
					// If not crushed, fallthrough to horizontal collision
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
			else
			{
				if _y_clip < 16 && _type != SOLID_TYPE.SIDES
				{
					if _player.vel_y >= 0
					{
						if _px >= _bbleft - _ext_x && _px <= _bbright + _ext_x - 1
						{
							m_attach_player(_type, _player, id, _bbtop);
						}
					}
				}
				else
				{
					_player.m_clear_solid_push(id);
				}
				
				// Do not run horizontal collision
				return;	
			}
		}
		
		// HORIZONTAL COLLISION
		
		if !_s3_method && abs(_y_clip) <= _grip_y
		{
			_player.m_clear_solid_push(id);
			return;
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
		if _px >= _bbleft - _ext_x && _px <= _bbright + _ext_x - 1
		{
			var _y_clip = _bbtop - (_py2 + _pry);
			
			if _y_clip >= -16 && _y_clip < 0
			{
				m_attach_player(_type, _player, id, _bbtop);
			}
		}
	}
}

m_attach_player = function(_type, _player, _obj, _bbtop)
{
	solid_touch[_player.player_index] = SOLID_TOUCH.TOP;
	
	if _type == SOLID_TYPE.FULL_NO_LAND || _type == SOLID_TYPE.TOP_NO_LAND
	{
		return;
	}
	
	if _type == SOLID_TYPE.FULL_RESET || _type == SOLID_TYPE.TOP_RESET
	{
		_player.m_reset_substate();
	}
	
	_player.y = _bbtop - 1 - _player.solid_radius_y;
	_player.spd_ground	= _player.vel_x;
	_player.vel_y = 0;
	_player.angle = 0;
	_player.on_object = _obj;
	
	if !_player.is_grounded
	{
		_player.m_land();
	}
}

solid_offsets = [];
solid_balance = false;
solid_push = array_create(PLAYER_MAX_COUNT, false);
solid_touch = array_create(PLAYER_MAX_COUNT, SOLID_TOUCH.NONE);