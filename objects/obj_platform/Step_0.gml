switch (state)
{
	case PLATFORMSTATE.MOVE:
	
		var _player_touch = false;

		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			var _player = player_get(_p);
			
			if (obj_check_solid(_player, SOLIDCOLLISION.TOP))
			{
				_player_touch = true;
			}
		}
		
		var _weight_inc = 5.625;

		if (_player_touch)
		{
			if (weight < 90)
			{
				weight += _weight_inc;
			}
		}
		else if (weight > 0)
		{
			weight -= _weight_inc;
		}
		
		var _osc_angle = obj_framework.frame_counter * ANGLE_INCREMENT;
		var _spd = 256 / vd_speed_multiplier;

		switch (vd_type)
		{
			case "None":
				y = ystart;
			break;
			
			case "Horizontal":
			
				x = math_oscillate_x(xstart, _osc_angle, vd_distance, _spd, vd_angle_offset);
				y = ystart;
				
			break;

			case "Vertical":
				y = math_oscillate_y(ystart, _osc_angle, vd_distance, _spd, vd_angle_offset + 270);
			break;

			case "Circular":
			
				x = math_oscillate_x(xstart, _osc_angle, vd_distance, _spd, vd_angle_offset);
				y = math_oscillate_y(ystart, _osc_angle, vd_distance, _spd, vd_angle_offset + 270);
				
			break;

			case "Falls":
				
				y = ystart;
				
				if (wait_timer == 0)
				{
					if (_player_touch)
					{
						wait_timer = 30;
					}
				}
				else if (--wait_timer == 0)
				{
					state = PLATFORMSTATE.FALL;
					wait_timer = 32;
				}
				
			break;
		}

		y += dsin(weight) * 4;
		
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			obj_act_solid(player_get(_p), SOLIDOBJECT.TOP);
		}

	break;

	case PLATFORMSTATE.FALL:
	
		if (--wait_timer == 0)
		{
			with (obj_player)
			{
				if (on_object == other.id)
				{
					is_grounded = false;
					on_object = noone;
					vel_y = other.vel_y;
				}
			}
		}

		y += vel_y;
		vel_y += 0.21875;
		
		if (wait_timer > 0)
		{
			for (var _p = 0; _p < PLAYER_COUNT; _p++)
			{
				obj_act_solid(player_get(_p), SOLIDOBJECT.TOP, SOLIDATTACH.NONE);
			}
		}

	break;
}