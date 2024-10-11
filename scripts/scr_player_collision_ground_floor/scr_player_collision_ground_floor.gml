/// @function scr_player_collision_ground_floor()
/// @self obj_player
function scr_player_collision_ground_floor()
{
	/// @feather ignore GM2044
	
	gml_pragma("forceinline");

	if (on_object != noone)
	{
		exit;
	}

	/// @method _snap_angle()
	var _snap_angle = function(_angle)
	{
		var _diff = abs(angle % 180 - _angle % 180);		
		
		if (_diff >= 45 && _diff <= 135)
		{
			_angle = round(angle / 90) % 4 * 90;
		}
		
		return _angle;
	}
	
	if (angle <= 45 || angle >= 315)
	{
		tile_behaviour = TILEBEHAVIOUR.DEFAULT;
	}
	else if (angle > 45 && angle < 135)
	{
		tile_behaviour = TILEBEHAVIOUR.ROTATE_90;
	}
	else if (angle >= 135 && angle <= 225)
	{
		tile_behaviour = TILEBEHAVIOUR.ROTATE_180;
	}
	else
	{
		tile_behaviour = TILEBEHAVIOUR.ROTATE_270;
	}
	
	var _min_tolerance = 4;
	var _max_tolerance = 14;
	
	var _player_physics = global.player_physics;

	switch (tile_behaviour)
	{
		case TILEBEHAVIOUR.DEFAULT:
			
			var _y = y + radius_y;
			var _floor_data = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.POSITIVE, tile_layer, tile_behaviour);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if (!stick_to_convex)
			{
				var _tolerance = _player_physics < PHYSICS.S2 ? _max_tolerance : min(_min_tolerance + abs(floor(vel_x)), _max_tolerance);

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
		
			if (_player_physics >= PHYSICS.S2)
			{
				_floor_angle = _snap_angle(_floor_angle);
			}
		
			y += _floor_dist;
			angle = _floor_angle;
		
		break;
		
		case TILEBEHAVIOUR.ROTATE_90:
			
			var _x = x + radius_y;
			var _floor_data = tile_find_2h(_x, y + radius_x, _x, y - radius_x, DIRECTION.POSITIVE, tile_layer, tile_behaviour);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if (!stick_to_convex)
			{
				var _tolerance = _player_physics < PHYSICS.S2 ? _max_tolerance : min(_min_tolerance + abs(floor(vel_y)), _max_tolerance);
			
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
		
			if (_player_physics >= PHYSICS.S2)
			{
				_floor_angle = _snap_angle(_floor_angle);
			}
		
			x += _floor_dist;
			angle = _floor_angle;
		
		break;
		
		case TILEBEHAVIOUR.ROTATE_180:
			
			var _y = y - radius_y;
			var _floor_data = tile_find_2v(x + radius_x, _y, x - radius_x, _y, DIRECTION.NEGATIVE, tile_layer, tile_behaviour);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if !stick_to_convex
			{
				var _tolerance = _player_physics ? _max_tolerance : min(_min_tolerance + abs(floor(vel_x)), _max_tolerance);
			
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
		
			if (_player_physics >= PHYSICS.S2)
			{
				_floor_angle = _snap_angle(_floor_angle);
			}
		
			y -= _floor_dist;
			angle = _floor_angle;
		
		break;
		
		case TILEBEHAVIOUR.ROTATE_270:
			
			var _x = x - radius_y;
			var _floor_data = tile_find_2h(_x, y - radius_x, _x, y + radius_x, DIRECTION.NEGATIVE, tile_layer, tile_behaviour);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if (!stick_to_convex)
			{
				var _tolerance = _player_physics < PHYSICS.S2 ? _max_tolerance : min(_min_tolerance + abs(floor(vel_y)), _max_tolerance);
			
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
		
			if (_player_physics >= PHYSICS.S2)
			{
				_floor_angle = _snap_angle(_floor_angle);
			}
		
			x -= _floor_dist;
			angle = _floor_angle;
		
		break;
	}
}