if (!obj_act_enemy())
{
	return;
}

var _floor_data;
var _floor_dist;
var _floor_angle;

switch (state)
{
	case CRABMEATSTATE.INIT:
	
		y += vel_y;
		vel_y += 0.21875;
		
		_floor_data = tile_find_v(x, y + 16, DIRECTION.POSITIVE);
		_floor_dist = _floor_data[0];
		_floor_angle = _floor_data[1];
		
		if (_floor_dist < 0)
		{
			y += _floor_dist;
			angle = _floor_angle;
			vel_y = 0;
			state = CRABMEATSTATE.WAIT;
		}
		
	break;
	
	case CRABMEATSTATE.WAIT:
		
		if (--state_timer >= 0)
		{
			break;
		}
		
		if (obj_is_visible())
		{
			shot_flag = !shot_flag;
			if (shot_flag)
			{
				for (var _i = -1; _i <= 1; _i += 2)
				{
					instance_create(x + 10 * _i, y, obj_crabmeat_projectile, { image_xscale: _i });
				}
				
				state_timer = 59;
				obj_set_anim(spr_crabmeat_fire, 0, 0, 0);
				break;
			}
		}
		
		visible = true;
		state = CRABMEATSTATE.MOVE;
		state_timer = 127;
		vel_x *= -1;	
		update_move_sprite();
		obj_set_anim(sprite_index, 16, 0, 0);
		
	break;
	
	case CRABMEATSTATE.MOVE:
	
		if (--state_timer >= 0)
		{
			x += vel_x;
			
			var _check_x = x;
			var _check_side = state_timer % 2 == 0;
			
			if (_check_side)
			{
				_check_x = vel_x < 0 ? x - 16 : x + 16;
			}
			
			_floor_data = tile_find_v(_check_x, y + 16, DIRECTION.POSITIVE);
			_floor_dist = _floor_data[0];
			_floor_angle = _floor_data[1];
			
			if (!_check_side)
			{
				y += _floor_dist;
				angle = _floor_angle;				
				update_move_sprite();
				break;
			}
			
			if (_floor_dist >= -8 && _floor_dist < 12)
			{
				break;
			}
		}
		
		state = CRABMEATSTATE.WAIT;
		state_timer = 59;
		obj_set_anim(spr_crabmeat_idle, 0, is_on_slope() ? 1 : 0, 0);
		
	break;
}