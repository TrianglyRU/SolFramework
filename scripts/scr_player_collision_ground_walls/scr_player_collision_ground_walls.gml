/// @self obj_player
function scr_player_collision_ground_walls()
{
	if angle > 90 && angle <= 270
	{
	    if global.player_physics < PHYSICS.SK || angle % 90 != 0
	    {
	        return;
	    }
	}
	
	var _wall_radius = radius_x_normal + 1;
	var _y_offset = angle == 0 ? 8 : 0;
	var _angle_quad = math_get_quadrant(angle);
	var _wall_quad;
	
	// _wall_quad's angle ranges are differnt from the math_get_quadrant() ones
	if angle >= 45 && angle <= 128
	{
	    _wall_quad = QUADRANT.RIGHT;
	}
	else if angle > 128 && angle < 225
	{
	    _wall_quad = QUADRANT.UP;
	}
	else if angle >= 225 && angle < 315
	{
	    _wall_quad = QUADRANT.LEFT;
	}
	else
	{
		_wall_quad = QUADRANT.DOWN;
	}

	if spd_ground < 0
	{
	    var _wall_dist;
	    var _x = x + vel_x;
	    var _y = y + vel_y;
		
	    switch _wall_quad
	    {
	        case QUADRANT.RIGHT:
	            _wall_dist = collision_tile_v(_x, _y + _wall_radius, 1, secondary_layer, _wall_quad)[0];
	        break;
			
	        case QUADRANT.UP:
	            _wall_dist = collision_tile_h(_x + _wall_radius, _y, 1, secondary_layer, _wall_quad)[0];
	        break;
			
	        case QUADRANT.LEFT:
	            _wall_dist = collision_tile_v(_x, _y - _wall_radius, -1, secondary_layer, _wall_quad)[0];
	        break;
			
			// QUADRANT.DOWN
			default:
				_wall_dist = collision_tile_h(_x - _wall_radius, _y + _y_offset, -1, secondary_layer, _wall_quad)[0];
	    }

	    if _wall_dist >= 0
	    {
	        return;
	    }
		
	    switch _angle_quad
	    {
	        case QUADRANT.DOWN:
			
	            vel_x -= _wall_dist;
	            spd_ground = 0;
				
	            if facing == -1 && animation != ANIM.SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.RIGHT:
	            vel_y += _wall_dist;
	        break;
			
	        case QUADRANT.UP:
			
	            vel_x += _wall_dist;
	            spd_ground = 0;
				
	            if facing == -1 && animation != ANIM.SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.LEFT:
	            vel_y -= _wall_dist;
	        break;
	    }
	}
	else if spd_ground > 0
	{
	    var _wall_dist;
	    var _x = x + vel_x;
	    var _y = y + vel_y;
		
	    switch _wall_quad
	    {
	        case QUADRANT.RIGHT:
	            _wall_dist = collision_tile_v(_x, _y - _wall_radius, -1, secondary_layer, _wall_quad)[0];
	        break;
			
	        case QUADRANT.UP:
	            _wall_dist = collision_tile_h(_x - _wall_radius, _y, -1, secondary_layer, _wall_quad)[0];
	        break;
			
	        case QUADRANT.LEFT:
	            _wall_dist = collision_tile_v(_x, _y + _wall_radius, 1, secondary_layer, _wall_quad)[0];
	        break;
			
			// QUADRANT.DOWN
			default:
	            _wall_dist = collision_tile_h(_x + _wall_radius, _y + _y_offset, 1, secondary_layer, _wall_quad)[0];
	    }
		
	    if _wall_dist >= 0
	    {
	        return;
	    }
		
	    switch _angle_quad
	    {
	        case QUADRANT.DOWN:
			
	            vel_x += _wall_dist;
	            spd_ground = 0;
				
	            if facing == 1 && animation != ANIM.SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.RIGHT:
	            vel_y -= _wall_dist;
	        break;
			
	        case QUADRANT.UP:
			
	            vel_x -= _wall_dist;
	            spd_ground = 0;
				
	            if facing == 1 && animation != ANIM.SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.LEFT:
	            vel_y += _wall_dist;
	        break;
	    }
	}
}