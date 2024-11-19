/// @function scr_player_camera()
/// @self obj_player
function scr_player_camera()
{
	gml_pragma("forceinline");
	
	if (camera_data.target != noone || player_index != camera_data.index)
	{
		return;
	}
	
	var _border_x = !global.cd_camera * 16;
	var _border_y = 32;
	var _width = camera_get_width(camera_data.index);
	var _height = camera_get_height(camera_data.index);
	var _target_x = floor(x) - camera_data.pos_x - _width / 2;
	var _target_y = floor(y) - camera_data.pos_y - _height / 2 + 16;
	
	if (_target_x > 0)
	{
		camera_data.vel_x = min(_target_x, 16);
	}
	else if (_target_x < -_border_x)
	{ 
		camera_data.vel_x = max(_target_x + _border_x, -16);  
	}
	else
	{
		camera_data.vel_x = 0;
	}
	
	if (is_grounded)
	{
		if (animation == ANIM.SPIN)
		{
			_target_y -= radius_y_normal - radius_y;
		}
		
		var _limit = abs(spd_ground) < 8 ? 6 : 16;
		
		camera_data.vel_y = clamp(_target_y, -_limit, _limit);
	}
	else if (_target_y > _border_y)
	{
		camera_data.vel_y = min(_target_y - _border_y, 16);  
	}
	else if (_target_y < -_border_y)
	{ 
		camera_data.vel_y = max(_target_y + _border_y, -16);  
	} 
	else
	{
		camera_data.vel_y = 0;
	}
	
	if (global.cd_camera)
	{
		var _x_shift_dist = 64;
		var _x_shift_spd = 2;
		var _x_shift_dir = spd_ground != 0 ? sign(spd_ground) : facing;
		
		if (abs(spd_ground) >= 6 || action == ACTION.SPINDASH)
		{
			if (camera_data.delay_x == 0 && camera_data.offset_x != _x_shift_dist * _x_shift_dir)
			{
				camera_data.offset_x += _x_shift_spd * _x_shift_dir;
			}
		}
		else if (camera_data.offset_x != 0)
		{
			camera_data.offset_x -= _x_shift_spd * sign(camera_data.offset_x);
		}
	}
	
	var _do_shift_down = animation == ANIM.DUCK;
	var _do_shift_up = animation == ANIM.LOOKUP;

	if (_do_shift_down || _do_shift_up)
	{
		if (camera_view_timer > 0 && state == PLAYERSTATE.DEFAULT)
		{
			camera_view_timer--;
		}
	}
	else if (global.spin_dash || global.dash)
	{
		camera_view_timer = CAMERA_VIEW_TIMER_DEFAULT;
	}

	if (camera_view_timer > 0)
	{
		if (camera_data.offset_y != 0)
		{
			camera_data.offset_y -= 2 * sign(camera_data.offset_y);
		}
	}
	else if (_do_shift_down && camera_data.offset_y < 88)
	{
		camera_data.offset_y += 2;
	}
	else if (_do_shift_up && camera_data.offset_y > -104)
	{
		camera_data.offset_y -= 2;
	}
}