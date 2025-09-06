/// @self obj_player
function scr_player_movement_roll()
{
	if ground_lock_timer == 0
	{
	    if input_down.left
	    {
	        if spd_ground > 0
	        {
	            spd_ground -= dec_roll;
				
	            if spd_ground < 0
	            {
	                spd_ground = -0.5;
	            }
	        }
	        else
	        {
	            facing = -1;
	            set_push_anim_by = noone;
	        }
	    }

	    if input_down.right
	    {
	        if spd_ground < 0
	        {
	            spd_ground += dec_roll;
				
	            if spd_ground >= 0
	            {
	                spd_ground = 0.5;
	            }
	        }
	        else
	        {
	            facing = 1;
	            set_push_anim_by = noone;
	        }
	    }
	}
	
	if spd_ground > 0
	{
	    spd_ground = max(spd_ground - frc_roll, 0);
	}
	else if spd_ground < 0
	{
	    spd_ground = min(spd_ground + frc_roll, 0);
	}

	if !forced_roll
	{
	    if spd_ground == 0 || global.player_physics == PHYSICS.SK && abs(spd_ground) < 0.5
	    {
	        y += solid_radius_y - radius_y_normal;
	        solid_radius_x = radius_x_normal;
	        solid_radius_y = radius_y_normal;
	        animation = ANIM.IDLE;
	    }
	}
	else
	{
	    if global.player_physics == PHYSICS.CD
	    {
	        if spd_ground >= 0 && spd_ground < 2
	        {
	            spd_ground = 2;
	        }
	    }
	    else if spd_ground == 0
	    {
	        spd_ground = global.player_physics == PHYSICS.S1 ? 2 : 4 * facing;
	    }
	}
	
	set_velocity();
	
	if global.roll_speed_cap
	{
		vel_x = clamp(vel_x, -16, 16);
	}
}
