/// @function _snap_angle()
function _snap_angle(_angle)
{
	gml_pragma("forceinline");
		
	var _diff = abs(angle % 180 - _angle % 180);
	if (_diff >= 45 && _diff <= 135)
	{
		_angle = round(angle / 90) % 4 * 90;
	}
		
	return _angle;
}

/// @self obj_player
/// @feather ignore GM2044
/// @function scr_player_collision_ground_floor()
function scr_player_collision_ground_floor()
{
	gml_pragma("forceinline");
	
	if (on_object != noone && instance_exists(on_object))
	{
		return;
	}
	
	var _angle_quad = QUADRANT.DOWN; _angle_quad = math_get_quadrant(angle);
	var _min_tolerance = 4;
	var _max_tolerance = 14;
	var _player_physics = global.player_physics;
	
	switch (_angle_quad)
	{
		case QUADRANT.DOWN:
			
			var _y = y + radius_y;
			var _floor_data = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.POSITIVE, secondary_layer, _angle_quad);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
			
			if (_player_physics >= PHYSICS.S2 || global.better_angle_snap)
			{
				_floor_angle = _snap_angle(_floor_angle);
			}
			
			if (!stick_to_convex)
			{
				var _tolerance = _player_physics < PHYSICS.S2 ? _max_tolerance : min(_min_tolerance + abs(floor(vel_x)), _max_tolerance);
				if (_floor_angle != _floor_data[1] && global.better_angle_snap)
				{
					_tolerance = 0;
				}
				
				if (_floor_dist > _tolerance)
				{
					set_push_anim_by = noone;
					is_grounded = false;
					
					if (animation != ANIM.FLIP)
					{
						obj_restart_anim();
					}
					
					break;
				}
			}
			
			if (_floor_dist < -_max_tolerance)
			{
				break;
			}
		
			y += _floor_dist;
			angle = _floor_angle;
		
		break;
		
		case QUADRANT.RIGHT:
			
			var _x = x + radius_y;
			var _floor_data = tile_find_2h(_x, y + radius_x, _x, y - radius_x, DIRECTION.POSITIVE, secondary_layer, _angle_quad);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
			
			if (_player_physics >= PHYSICS.S2 || global.better_angle_snap)
			{
				_floor_angle = _snap_angle(_floor_angle);
			}
			
			if (!stick_to_convex)
			{
				var _tolerance = _player_physics < PHYSICS.S2 ? _max_tolerance : min(_min_tolerance + abs(floor(vel_y)), _max_tolerance);
				if (_floor_angle != _floor_data[1] && global.better_angle_snap)
				{
					_tolerance = 0;
				}
				
				if (_floor_dist > _tolerance)
				{
					set_push_anim_by = noone;
					is_grounded = false;
					
					if (animation != ANIM.FLIP)
					{
						obj_restart_anim();
					}
					
					break;
				}
			}
			
			if (_floor_dist < -_max_tolerance)
			{
				break;
			}
			
			x += _floor_dist;
			angle = _floor_angle;
		
		break;
		
		case QUADRANT.UP:
			
			var _y = y - radius_y;
			var _floor_data = tile_find_2v(x + radius_x, _y, x - radius_x, _y, DIRECTION.NEGATIVE, secondary_layer, _angle_quad);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
			
			if (_player_physics >= PHYSICS.S2 || global.better_angle_snap)
			{
				_floor_angle = _snap_angle(_floor_angle);
			}
			
			if (!stick_to_convex)
			{
				var _tolerance = _player_physics < PHYSICS.S2 ? _max_tolerance : min(_min_tolerance + abs(floor(vel_x)), _max_tolerance);
				if (_floor_angle != _floor_data[1] && global.better_angle_snap)
				{
					_tolerance = 0;
				}
				
				if (_floor_dist > _tolerance)
				{
					set_push_anim_by = noone;
					is_grounded = false;
					
					if (animation != ANIM.FLIP)
					{
						obj_restart_anim();
					}
					
					break;
				}
			}
		
			if (_floor_dist < -_max_tolerance)
			{
				break;
			}
		
			y -= _floor_dist;
			angle = _floor_angle;
		
		break;
		
		case QUADRANT.LEFT:
			
			var _x = x - radius_y;
			var _floor_data = tile_find_2h(_x, y - radius_x, _x, y + radius_x, DIRECTION.NEGATIVE, secondary_layer, _angle_quad);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if (_player_physics >= PHYSICS.S2 || global.better_angle_snap)
			{
				_floor_angle = _snap_angle(_floor_angle);
			}
			
			if (!stick_to_convex)
			{
				var _tolerance = _player_physics < PHYSICS.S2 ? _max_tolerance : min(_min_tolerance + abs(floor(vel_y)), _max_tolerance);
				if (_floor_angle != _floor_data[1] && global.better_angle_snap)
				{
					_tolerance = 0;
				}
				
				if (_floor_dist > _tolerance)
				{
					set_push_anim_by = noone;
					is_grounded = false;
					
					if (animation != ANIM.FLIP)
					{
						obj_restart_anim();
					}
					
					break;
				}
			}
		
			if (_floor_dist < -_max_tolerance)
			{
				break;
			}
		
			x -= _floor_dist;
			angle = _floor_angle;
		
		break;
	}
}