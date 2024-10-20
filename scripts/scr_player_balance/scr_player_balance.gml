/// @function scr_player_balance
/// @self obj_player
function scr_player_balance()
{
	gml_pragma("forceinline");
	
	if (action == ACTION.SPINDASH || action == ACTION.DASH || spd_ground != 0)
	{
		return;
	}
	
	if (global.player_physics == PHYSICS.SK)
	{
		if (input_down.down || input_down.up && global.dash)
		{
			return;
		}
	}

	/// @method _balance_left()
	var _balance_left = function(_panic_cond)
	{
		switch (vd_player_type)
		{
			case PLAYER.SONIC:
			
				if (super_timer > 0)
				{
					animation = ANIM.BALANCE;
					facing = DIRECTION.NEGATIVE;
				}
				else if (!_panic_cond)
				{
					animation = facing == DIRECTION.NEGATIVE ? ANIM.BALANCE : ANIM.BALANCE_FLIP;
				}
				else if (facing == DIRECTION.POSITIVE)
				{
					animation = ANIM.BALANCE_TURN;
					facing = DIRECTION.NEGATIVE;
				}
				else if (animation != ANIM.BALANCE_TURN)
				{
					animation = ANIM.BALANCE_PANIC;
				}
			
			break;
			
			case PLAYER.TAILS:
			case PLAYER.AMY:
				
				animation = ANIM.BALANCE;
				facing = DIRECTION.NEGATIVE;
			
			break;
			
			case PLAYER.KNUCKLES:
			
				if (facing == DIRECTION.NEGATIVE)
				{
					animation = ANIM.BALANCE;
				}
				else if (animation != ANIM.BALANCE_FLIP)
				{
					animation = ANIM.BALANCE_FLIP;
					facing = DIRECTION.NEGATIVE;
				}
			
			break;
		}
	}
	
	/// @method _balance_right()
	var _balance_right = function(_panic_cond)
	{
		switch (vd_player_type)
		{
			case PLAYER.SONIC:
			
				if (super_timer > 0)
				{
					animation = ANIM.BALANCE;
					facing = DIRECTION.POSITIVE;
				}
				else if (!_panic_cond)
				{
					animation = facing == DIRECTION.POSITIVE ? ANIM.BALANCE : ANIM.BALANCE_FLIP;
				}
				else if (facing == DIRECTION.NEGATIVE)
				{
					animation = ANIM.BALANCE_TURN;
					facing = DIRECTION.POSITIVE;
				}
				else if animation != ANIM.BALANCE_TURN
				{
					animation = ANIM.BALANCE_PANIC;
				}
			
			break;
			
			case PLAYER.TAILS:
			case PLAYER.AMY:
				
				animation = ANIM.BALANCE;
				facing = DIRECTION.POSITIVE;
			
			break;
			
			case PLAYER.KNUCKLES:
			
				if (facing == DIRECTION.POSITIVE)
				{
					animation = ANIM.BALANCE;
				}
				else if (animation != ANIM.BALANCE_FLIP)
				{
					animation = ANIM.BALANCE_FLIP;
					facing = DIRECTION.POSITIVE;
				}
			
			break;
		}
	}

	if (on_object == noone)
	{
		/// @feather ignore GM1041
		if (math_get_quadrant(angle) != QUADRANT.DOWN)
		{
			return;
		}
		
		var _y = y + radius_y;
		var _floor_dist = tile_find_v(x, _y, DIRECTION.POSITIVE, tile_layer)[0];	
		
		if (_floor_dist < 12)
		{
			return;
		}
		
		var _angle_left = tile_find_v(x - radius_x, _y, DIRECTION.POSITIVE, tile_layer)[1];
		var _angle_right = tile_find_v(x + radius_x, _y, DIRECTION.POSITIVE, tile_layer)[1];
		
		if (_angle_left == TILE_EMPTY_ANGLE && _angle_right == TILE_EMPTY_ANGLE
		|| _angle_left != TILE_EMPTY_ANGLE && _angle_right != TILE_EMPTY_ANGLE)
		{
			return;
		}
		
		if (_angle_left == TILE_EMPTY_ANGLE)
		{	
			var _left_dist = tile_find_v(x + 6, _y, DIRECTION.POSITIVE, tile_layer)[0];
			
			_balance_left(_left_dist >= 12);
		}
		else if (_angle_right == TILE_EMPTY_ANGLE)
		{
			var _right_dist = tile_find_v(x - 6, _y, DIRECTION.POSITIVE, tile_layer)[0];
			
			_balance_right(_right_dist >= 12);
		}
		
		return;
	}
	else if (instance_exists(on_object))
	{
		var _obj = on_object;
		
		if (_obj.solid_disable_balance)
		{
			return;
		}
		
		var _left_edge = 2;
		var _right_edge = _obj.solid_radius_x * 2 - _left_edge;
		var _player_x = _obj.solid_radius_x - floor(_obj.x) + floor(x);
		
		if (_player_x < _left_edge)
		{
			_balance_left(_player_x < _left_edge - 4);
		}
		else if (_player_x > _right_edge)
		{
			_balance_right(_player_x > _right_edge + 4);
		}
	}
}