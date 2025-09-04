/// @self obj_player
function scr_player_glide_collision()
{
	if action != ACTION.GLIDE
	{
	    return;
	}
	
	var _vector = math_get_vector_rounded(vel_x, vel_y);
	var _move_quad = math_get_quadrant(_vector);
	var _climb_y = y;
	var _wall_radius = radius_x_normal + 1;
	var _collision_flag_wall = false;
	var _collision_flag_floor = false;
	
	if _move_quad != QUADRANT.RIGHT
	{
	    var _wall_dist = collision_tile_h(x - _wall_radius, y, -1, secondary_layer)[0];
		
	    if _wall_dist < 0
	    {
	        x -= _wall_dist;
	        vel_x = 0;
			
			_collision_flag_wall = true;
	    }
	}
	
	if _move_quad != QUADRANT.LEFT
	{
	    var _wall_dist = collision_tile_h(x + _wall_radius, y, 1, secondary_layer)[0];
		
	    if _wall_dist < 0
	    {
	        x += _wall_dist;
	        vel_x = 0;
			
			_collision_flag_wall = true;
	    }
	}
	
	if _move_quad != QUADRANT.DOWN
	{
	    var _y = y - solid_radius_y;
	    var _roof_dist = collision_tile_2v(x - solid_radius_x, _y, x + solid_radius_x, _y, -1, secondary_layer)[0];
    
	    if _roof_dist <= -14 && _move_quad == QUADRANT.LEFT && global.player_physics >= PHYSICS.S3
	    {
	        var _wall_dist = collision_tile_h(x + _wall_radius, y, 1, secondary_layer)[0];
			
	        if _wall_dist < 0
	        {
	            x += _wall_dist;
	            vel_x = 0;
				
				_collision_flag_wall = true;
	        }
	    }
	    else if _roof_dist < 0
	    {
	        y -= _roof_dist;
			
	        if vel_y < 0 || _move_quad == QUADRANT.UP
	        {
	            vel_y = 0;
	        }
	    }
	}

	if _move_quad != QUADRANT.UP
	{
	    var _y = y + solid_radius_y;
	    var _floor_data = collision_tile_2v(x - solid_radius_x, _y, x + solid_radius_x, _y, 1, secondary_layer);
	    var _floor_dist = _floor_data[0];
	    var _floor_angle = _floor_data[1];
    
	    if action_state == GLIDE_STATE.GROUND
	    {
	        if _floor_dist > 14
	        {
	            m_release_glide(0);
	        }
	        else
	        {
	            y += _floor_dist;
	            angle = _floor_angle;
	        }
			
	        return;
	    }
		
	    if _floor_dist < 0
	    {
	        y += _floor_dist;
	        angle = _floor_angle; 
	        vel_y = 0;
			
			_collision_flag_floor = true;
	    }
	}

	if _collision_flag_floor
	{
		var _floor_quad = math_get_quadrant(angle);
		
		if action_state == GLIDE_STATE.AIR
		{
			if _floor_quad == QUADRANT.DOWN
			{
			    animation = ANIM.GLIDE_GROUND;
			    action_state = GLIDE_STATE.GROUND;
			    grv = 0;
			}
			else
			{
				spd_ground = angle < 180 ? vel_x : -vel_x; 
				m_land();
			}
		}
		else if action_state == GLIDE_STATE.FALL
		{
		    m_land();
			
		    if _floor_quad == QUADRANT.DOWN
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
			
			audio_play_sfx(snd_land);
		}
	}
	else if _collision_flag_wall && action_state == GLIDE_STATE.AIR
	{
	    var _wall_dist = collision_tile_h(x + _wall_radius * facing, _climb_y - solid_radius_y, facing, secondary_layer)[0];	
		
	    if _wall_dist != 0
	    {
	        var _floor_dist = collision_tile_v(x + (_wall_radius + 1) * facing, _climb_y - solid_radius_y - 1, 1, secondary_layer, QUADRANT.UP)[0];
			
	        if  _floor_dist < 0 || _floor_dist >= 12
	        {
	            m_release_glide(0);
	            return;
	        }
			
	        y += _floor_dist;
	    }
		
	    if facing == -1
	    {
	        x++;
	    }
		
	    action_state = CLIMB_STATE.NORMAL;
	    action = ACTION.CLIMB;
	    animation = ANIM.CLIMB_WALL;
	    climb_value = 0;
		spd_ground = 0;
	    vel_y = 0;
	    grv = 0;
		
	    audio_play_sfx(snd_grab);
	}
}