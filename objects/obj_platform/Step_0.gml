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
		
		var _osc_angle = obj_game.frame_counter * ANGLE_INCREMENT;
		var _spd = 256 / vd_speed_multiplier;

		switch (vd_type)
		{
			case PLATFORMTYPE.DEFAULT:
				y = ystart;
			break;
			case PLATFORMTYPE.HORIZONTAL:
			
				x = math_oscillate_x(xstart, _osc_angle, vd_distance, _spd, vd_angle_offset);
				y = ystart;
				
			break;
			case PLATFORMTYPE.VERTICAL:
				y = math_oscillate_y(ystart, _osc_angle, vd_distance, _spd, vd_angle_offset + 270);
			break;
			case PLATFORMTYPE.CIRCULAR:
			
				x = math_oscillate_x(xstart, _osc_angle, vd_distance, _spd, vd_angle_offset);
				y = math_oscillate_y(ystart, _osc_angle, vd_distance, _spd, vd_angle_offset + 270);
				
			break;
			case PLATFORMTYPE.FALL:
				
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
					on_object = noone;
					is_grounded = false;
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

if (vd_type == PLATFORMTYPE.DEFAULT)
{
	var _itembox = instance_place(xprevious, yprevious - 1, obj_itembox);
	if (_itembox != noone)
	{
		// Item Box's state may not be initialised yet
		if (!variable_instance_exists(_itembox, "state") || _itembox.state != ITEMBOXSTATE.FALL)
		{
			_itembox.x += x - xprevious;
			_itembox.y += y - yprevious;
		}
	}
}
