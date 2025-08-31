switch state
{
	case PLATFORM_STATE.MOVE:
	
		var _player_touch = false;
		
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			if solid_touch[_p] == SOLID_TOUCH.TOP
			{
				_player_touch = true;
			}
		}
		
		var _weight_inc = 5.625;
		
		if _player_touch
		{
			if weight < 90
			{
				weight += _weight_inc;
			}
		}
		else if weight > 0
		{
			weight -= _weight_inc;
		}
		
		var _osc_angle = obj_game.frame_counter * ANGLE_INCREMENT;
		var _spd = 256 / iv_speed_multiplier;
	
		switch iv_type
		{
			case PLATFORM_TYPE.DEFAULT:
				y = ystart;
			break;
			
			case PLATFORM_TYPE.HORIZONTAL:
			
				x = math_oscillate_x(xstart, _osc_angle, iv_radius, _spd, iv_angle_offset);
				y = ystart;
				
			break;
			
			case PLATFORM_TYPE.VERTICAL:
				y = math_oscillate_y(ystart, _osc_angle, iv_radius, _spd, iv_angle_offset + 270);
			break;
			
			case PLATFORM_TYPE.CIRCULAR:
			
				x = math_oscillate_x(xstart, _osc_angle, iv_radius, _spd, iv_angle_offset);
				y = math_oscillate_y(ystart, _osc_angle, iv_radius, _spd, iv_angle_offset + 270);
				
			break;
			
			case PLATFORM_TYPE.FALL:
				
				y = ystart;
				
				if wait_timer == 0
				{
					if _player_touch
					{
						wait_timer = 30;
					}
				}
				else if --wait_timer == 0
				{
					state = PLATFORM_STATE.FALL;
					wait_timer = 32;
				}
				
			break;
		}
		
		y += dsin(weight) * 4;
		
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			instance_solid(player_get(_p), SOLID_TYPE.TOP);
		}

	break;
	
	case PLATFORM_STATE.FALL:
		
		if --wait_timer == 0
		{
			with obj_player
			{
				if on_object == other.id
				{
					on_object = noone;
					is_grounded = false;
					vel_y = other.vel_y;
				}
			}
		}
		
		y += vel_y;
		vel_y += 0.21875;
		
		if wait_timer > 0
		{
			for (var _p = 0; _p < PLAYER_COUNT; _p++)
			{
				var _player = player_get(_p);
				
				if _player.on_object == id
				{
					instance_solid(_player, SOLID_TYPE.TOP);
				}
			}
		}

	break;
}