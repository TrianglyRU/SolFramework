switch state
{
	case PLATFORM_STATE.MOVE:
	
		var _found_player = false;
		
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			if solid_touch[_p] == SOLID_TOUCH.TOP
			{
				_found_player = true;
			}
		}
		
		var _weight_inc = 5.625;
		
		if _found_player
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
	
		switch iv_type
		{
			case PLATFORM_TYPE.DEFAULT:
				y = ystart;
			break;
			
			case PLATFORM_TYPE.HORIZONTAL:
			
				x = math_oscillate_x(xstart, _osc_angle, iv_radius, iv_speed_multiplier, iv_angle_offset);
				y = ystart;
				
			break;
			
			case PLATFORM_TYPE.VERTICAL:
				y = math_oscillate_y(ystart, _osc_angle - 90, iv_radius, iv_speed_multiplier, iv_angle_offset);
			break;
			
			case PLATFORM_TYPE.CIRCULAR:
			
				x = math_oscillate_x(xstart, _osc_angle, iv_radius, iv_speed_multiplier, iv_angle_offset);
				y = math_oscillate_y(ystart, _osc_angle - 180, iv_radius, iv_speed_multiplier, iv_angle_offset);
				
			break;
			
			case PLATFORM_TYPE.FALL:
				
				y = ystart;
				
				if wait_timer == 0
				{
					if _found_player
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
			solid_object(player_get(_p), SOLID_TYPE.TOP);
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
				solid_object(player_get(_p), SOLID_TYPE.TOP_NO_LAND);
			}
		}

	break;
}

var _list_size = ds_list_size(synced_objects);

if _list_size > 0
{
	for (var _i = 0; _i < _list_size; _i++)
	{
		var _obj = synced_objects[| _i];
		
		_obj.x = _obj.xstart + x - xstart;
		_obj.y = _obj.ystart + y - ystart;
	}
}