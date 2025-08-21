/// @self obj_player
/// @function scr_player_level_bound()
function scr_player_level_bound()
{
	gml_pragma("forceinline");
	
	var _left_bound = camera_data.left_bound + 16;
	var _right_bound = camera_data.right_bound - 24;
	var _top_bound = camera_data.top_bound + 16;
	var _bottom_bound = camera_data.bottom_bound;
	
	// Most of the checks here use not floored but real positions including
	// subpixels (_i.e., LONG instead of WORD)
	
	if (x + vel_x < _left_bound)
	{
		spd_ground = 0;
		vel_x = 0;
		x = _left_bound;
	}
	
	if (instance_exists(obj_signpost))
	{
		_right_bound += 64;
	}
	
	if (x + vel_x > _right_bound)
	{
		spd_ground = 0;
		vel_x = 0;
		x = _right_bound;
	}
	
	if (action == ACTION.FLIGHT || action == ACTION.CLIMB)
	{
		if (y + vel_y < _top_bound)
		{ 	
			if (action == ACTION.FLIGHT)
			{
				grv = PARAM_GRV_TAILS_DOWN;
			}
			
			vel_y = 0;
			y = _top_bound;
		}
	}
	else if (action == ACTION.GLIDE && y < _top_bound - 6)
	{
		// Reset glide speed
		spd_ground = 0;
	}
	
	if (instance_exists(obj_rm_stage))
	{
		if (air_timer > 0 && floor(y) >= max(_bottom_bound, obj_rm_stage.bottom_bound[camera_data.index]))
		{
			self.kill();
		}
	}
}