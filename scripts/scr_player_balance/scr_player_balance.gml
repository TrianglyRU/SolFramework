/// @self obj_player
function scr_player_balance()
{
	if action == ACTION.SPINDASH || action == ACTION.DASH || spd_ground != 0
	{
		return;
	}
	
	if global.player_physics == PHYSICS.SK
	{
		if input_down.down || input_down.up && global.dash
		{
			return;
		}
	}
	
	if on_object == noone
	{
		if math_get_quadrant(angle) != QUADRANT.DOWN
		{
			return;
		}
		
		var _y = y + solid_radius_y;
		var _floor_dist = tile_find_v(x, _y, 1, secondary_layer)[0];	
		
		if _floor_dist < 12
		{
			return;
		}
		
		var _angle_left = tile_find_v(x - solid_radius_x, _y, 1, secondary_layer)[1];
		var _angle_right = tile_find_v(x + solid_radius_x, _y, 1, secondary_layer)[1];
		
		if _angle_left == TILE_EMPTY_ANGLE && _angle_right == TILE_EMPTY_ANGLE
		|| _angle_left != TILE_EMPTY_ANGLE && _angle_right != TILE_EMPTY_ANGLE
		{
			return;
		}
		
		if _angle_left == TILE_EMPTY_ANGLE
		{	
			_balance_left(tile_find_v(x + 6, _y, 1, secondary_layer)[0] >= 12);
		}
		else if _angle_right == TILE_EMPTY_ANGLE
		{
			_balance_right(tile_find_v(x - 6, _y, 1, secondary_layer)[0] >= 12);
		}
	}
	else if instance_exists(on_object)
	{
		var _obj = on_object;
		
		if _obj.solid_disable_balance
		{
			return;
		}
		
		var _radius = _obj.solid_radius_x;
		var _left_edge = 2;
		var _right_edge = _radius * 2 - _left_edge;
		var _relative_x = _radius - floor(_obj.x) + floor(x);
		
		if _relative_x < _left_edge
		{
			_balance_left(_relative_x < _left_edge - 4);
		}
		else if _relative_x > _right_edge
		{
			_balance_right(_relative_x > _right_edge + 4);
		}
	}
}

/// @self scr_player_balance
function _balance_left(_panic_cond)
{
	gml_pragma("forceinline");
	
	switch player_type
	{
		case PLAYER.SONIC:
			
			if super_timer > 0
			{
				animation = ANIM.BALANCE;
				facing = -1;
			}
			else if !_panic_cond
			{
				animation = facing == -1 ? ANIM.BALANCE : ANIM.BALANCE_FLIP;
			}
			else if facing == 1
			{
				animation = ANIM.BALANCE_TURN;
				facing = -1;
			}
			else if animation != ANIM.BALANCE_TURN
			{
				animation = ANIM.BALANCE_PANIC;
			}
			
		break;
			
		case PLAYER.TAILS:
		case PLAYER.AMY:
				
			animation = ANIM.BALANCE;
			facing = -1;
			
		break;
			
		case PLAYER.KNUCKLES:
			
			if facing == -1
			{
				animation = ANIM.BALANCE;
			}
			else if animation != ANIM.BALANCE_FLIP
			{
				animation = ANIM.BALANCE_FLIP;
				facing = -1;
			}
			
		break;
	}
}

/// @self scr_player_balance
function _balance_right(_panic_cond)
{
	gml_pragma("forceinline");
		
	switch player_type
	{
		case PLAYER.SONIC:
			
			if super_timer > 0
			{
				animation = ANIM.BALANCE;
				facing = 1;
			}
			else if !_panic_cond
			{
				animation = facing == 1 ? ANIM.BALANCE : ANIM.BALANCE_FLIP;
			}
			else if facing == -1
			{
				animation = ANIM.BALANCE_TURN;
				facing = 1;
			}
			else if animation != ANIM.BALANCE_TURN
			{
				animation = ANIM.BALANCE_PANIC;
			}

		break;
		
		case PLAYER.TAILS:
		case PLAYER.AMY:
				
			animation = ANIM.BALANCE;
			facing = 1;
			
		break;
		
		case PLAYER.KNUCKLES:
			
			if facing == 1
			{
				animation = ANIM.BALANCE;
			}
			else if animation != ANIM.BALANCE_FLIP
			{
				animation = ANIM.BALANCE_FLIP;
				facing = 1;
			}
			
		break;
	}
}