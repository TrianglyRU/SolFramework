/// @function scr_player_glide_collision()
/// @self obj_player
function scr_player_glide_collision()
{
	gml_pragma("forceinline");

	if (action != ACTION.GLIDE)
	{
	    exit;
	}
	
	var _move_quad = math_get_quadrant(math_get_vector_rounded(vel_x, vel_y));
	var _climb_y = y;
	var _wall_radius = radius_x_normal + 1;
	var _collision_flag_wall = false;
	var _collision_flag_floor = false;
	
	if (_move_quad != QUADRANT.RIGHT)
	{
	    var _wall_dist = tile_find_h(x - _wall_radius, y, DIRECTION.NEGATIVE, tile_layer)[0];
		
	    if (_wall_dist < 0)
	    {
	        _collision_flag_wall = true;
	        x -= _wall_dist;
	        vel_x = 0;
	    }
	}
	
	if (_move_quad != QUADRANT.LEFT)
	{
	    var _wall_dist = tile_find_h(x + _wall_radius, y, DIRECTION.POSITIVE, tile_layer)[0];
		
	    if (_wall_dist < 0)
	    {
	        _collision_flag_wall = true;
	        x += _wall_dist;
	        vel_x = 0;
	    }
	}
	
	if (_move_quad != QUADRANT.DOWN)
	{
	    var _y = y - radius_y;
	    var _roof_dist = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.NEGATIVE, tile_layer)[0];
    
	    if (_roof_dist <= -14 && _move_quad == QUADRANT.LEFT && global.player_physics >= PHYSICS.S3)
	    {
	        var _wall_dist = tile_find_h(x + _wall_radius, y, DIRECTION.POSITIVE, tile_layer)[0];	
			
	        if (_wall_dist < 0)
	        {
	            _collision_flag_wall = true;
	            x += _wall_dist;
	            vel_x = 0;
	        }
	    }
	    else if (_roof_dist < 0)
	    {
	        y -= _roof_dist;
			
	        if (vel_y < 0 || _move_quad == QUADRANT.UP)
	        {
	            vel_y = 0;
	        }
	    }
	}

	if (_move_quad != QUADRANT.UP)
	{
	    var _y = y + radius_y;
	    var _floor_data = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.POSITIVE, tile_layer);
	    var _floor_dist = _floor_data[0];
	    var _floor_angle = _floor_data[1];
    
	    if (action_state == GLIDESTATE.GROUND)
	    {
	        if (_floor_dist > 14)
	        {
	            release_glide(0);
	        }
	        else
	        {
	            y += _floor_dist;
	            angle = _floor_angle;
	        }
			
	        exit;
	    }
		
	    if (_floor_dist < 0)
	    {
	        _collision_flag_floor = true;
	        y += _floor_dist;
	        angle = _floor_angle; 
	        vel_y = 0;
	    }
	}

	if (_collision_flag_floor)
	{
		var _floor_quad = math_get_quadrant(angle);

		if (action_state == GLIDESTATE.AIR)
		{
			if (_floor_quad == QUADRANT.DOWN)
			{
			    animation = ANIM.GLIDE_GROUND;
			    action_state = GLIDESTATE.GROUND;
			    grv = 0;
			}
			else
			{
			    spd_ground = angle < 180 ? vel_x : -vel_x;
			    land();
			}
		}
		else if (action_state == GLIDESTATE.FALL)
		{
		    land();
		    audio_play_sfx(snd_land);
			
		    if (_floor_quad == QUADRANT.DOWN)
		    {
		        animation = ANIM.GLIDE_LAND;
		        ground_lock_timer = 16;
				spd_ground = 0;
		        vel_x = 0;
		    }
		    else
		    {
		        spd_ground = vel_x;
		    }
		}
	}
	else if (_collision_flag_wall)
	{
	    if (action_state != GLIDESTATE.AIR)
	    {
	        exit;
	    }
		
	    var _wall_dist = tile_find_h(x + _wall_radius * facing, _climb_y - radius_y, facing, tile_layer)[0];	
		
	    if (_wall_dist != 0)
	    {
	        var _floor_dist = tile_find_v(x + (_wall_radius + 1) * facing, _climb_y - radius_y - 1, DIRECTION.POSITIVE, tile_layer, TILEBEHAVIOUR.ROTATE_90)[0];
			
	        if  (_floor_dist < 0 || _floor_dist >= 12)
	        {
	            release_glide(0);
	            exit;
	        }
			
	        y += _floor_dist;
	    }
		
	    if (facing == DIRECTION.NEGATIVE)
	    {
	        x++;
	    }
		
	    action_state = CLIMBSTATE.NORMAL;
	    action = ACTION.CLIMB;
	    animation = ANIM.CLIMB_WALL;
	    climb_value = 0;
		spd_ground = 0;
	    vel_y = 0;
	    grv = 0;
		
	    audio_play_sfx(snd_grab);
	}
}