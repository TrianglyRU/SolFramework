/// @self obj_player
/// @function scr_player_debug_mode()
function scr_player_debug_mode()
{
	gml_pragma("forceinline");
	
	if (input_down.up || input_down.down || input_down.left || input_down.right)
	{
	    debug_mode_spd = min(debug_mode_spd + 0.046875, 16);
		
	    if (input_down.up)
	    {
	        y -= debug_mode_spd;
	    }
		
	    if (input_down.down)
	    {
		  y += debug_mode_spd;
	    }
		
	    if (input_down.left)
	    {
	        x -= debug_mode_spd;
		}
		
	    if (input_down.right)
	    {
	        x += debug_mode_spd;
	    }
		
		x = clamp(x, camera_data.left_bound, camera_data.right_bound - 1);
		y = clamp(y, camera_data.top_bound, camera_data.bottom_bound - 1);
	}
	else
	{
	    debug_mode_spd = 0;
	}

	var _input_press = input_press;
	var _max_ind = array_length(debug_mode_array) - 1;

	if (_input_press.action1)
	{
	    if (++debug_mode_ind > _max_ind)
	    {
	        debug_mode_ind = 0;
	    }
	}
	else if (_input_press.action3)
	{
	    if (input_down.action1)
	    {
	        if (--debug_mode_ind < 0)
	        {
	            debug_mode_ind = _max_ind;
	        }
	    }
	    else
	    {
			var _object = instance_create(x, y, debug_mode_array[debug_mode_ind], { image_xscale: facing, depth: cull_depth });	
	        with (_object)
	        {
	            obj_set_culling(ACTIVEIF.INBOUNDS_DELETE);
	        }
	    }
	}
	else if (_input_press.action2)
	{
	    state = PLAYERSTATE.DEFAULT;
	    animation = ANIM.MOVE;
	    air_lock_flag = false;
	    is_underwater = false;
	    debug_mode_spd = 0;
	    spd_ground = 0;
	    vel_x = 0;
	    vel_y = 0;
		
		x = floor(x);
		y = floor(y);
		
	    reset_gravity();
	    reset_substate();
	}
}