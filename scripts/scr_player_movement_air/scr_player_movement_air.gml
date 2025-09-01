/// @self obj_player
/// @function scr_player_movement_air()
function scr_player_movement_air()
{
	if (action == ACTION.CARRIED || action == ACTION.CLIMB || action == ACTION.SPINDASH || self.is_true_glide())
	{
		return;
	}
	
	if (angle != 0)
	{
		angle += angle >= 180 ? 2.8125 : -2.8125;
		if (angle < 0 || angle >= 360)
		{
			angle = 0;
		}
	}

	if (!is_jumping && !forced_roll && action != ACTION.SPINDASH)
	{
		vel_y = max(-15.75, vel_y);
	}

	if (global.player_physics == PHYSICS.CD)
	{
		vel_y = min(vel_y, 16);
	}
	
	if (action == ACTION.HAMMERDASH)
	{
		return;
	}

	if (!air_lock_flag)
	{
		if (input_down.left)
		{
			if (vel_x > 0)
			{
				vel_x -= acc_air;
			}
			else if (global.speed_cap || vel_x > -acc_top)
			{
				vel_x = max(vel_x - acc_air, -acc_top);
			}
			
			facing = -1;
		}
		
		if (input_down.right)
		{
			if (vel_x < 0)
			{
				vel_x += acc_air;
			} 
			else if (global.speed_cap || vel_x < acc_top)
			{
				vel_x = min(vel_x + acc_air, acc_top);
			}
			
			facing = 1;
		}	
	}
	
	if (vel_y < 0 && vel_y > -4)
	{
		vel_x -= floor(vel_x / 0.125) / 256;
	}
}