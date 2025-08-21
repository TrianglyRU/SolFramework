/// @self obj_player
/// @function scr_player_movement_ground()
function scr_player_movement_ground()
{	
	if (action == ACTION.SPINDASH || action == ACTION.DASH || action == ACTION.HAMMERDASH)
	{
		return;
	}
	
	if ((animation == ANIM.GLIDE_GROUND || animation == ANIM.GLIDE_LAND) && (input_down.down || spd_ground != 0))
	{
		ground_lock_timer = 0;
	}
	
	if (ground_lock_timer == 0)
	{
		var _is_braking = false;
		
		if (input_down.left)
		{	
			if (spd_ground > 0)
			{
				spd_ground -= dec;
				if (spd_ground < 0)
				{
					spd_ground = -0.5;
				}
				
				_is_braking = true;
			}
			else
			{
				if (global.speed_cap || spd_ground > -acc_top)
				{
					spd_ground = max(spd_ground - acc, -acc_top);
				}
				
				if (facing != DIRECTION.NEGATIVE)
				{
					facing = DIRECTION.NEGATIVE;
					animation = ANIM.MOVE;
					set_push_anim_by = noone;
					
					obj_restart_anim();
				}
				
				// Cancel skid animation
				if (animation == ANIM.SKID)
				{
					animation = ANIM.MOVE;
				}
			}
		}
		
		if (input_down.right)
		{
			if (spd_ground < 0)
			{
				spd_ground += dec;			
				if (spd_ground >= 0)
				{
					spd_ground = 0.5;
				}
				
				_is_braking = true;
			} 
			else
			{
				if (global.speed_cap || spd_ground < acc_top)
				{
					spd_ground = min(spd_ground + acc, acc_top);
				}
				
				if (facing != DIRECTION.POSITIVE)
				{
					facing = DIRECTION.POSITIVE;
					animation = ANIM.MOVE;
					set_push_anim_by = noone;
					
					obj_restart_anim();
				}
				
				// Cancel skid animation
				if (animation == ANIM.SKID)
				{
					animation = ANIM.MOVE;
				}
			}
		}
		
		// Set push animation
		if (set_push_anim_by != noone && anim_frame_changed)
		{
			animation = ANIM.PUSH;
		}	
		
		var _angle_quad = math_get_quadrant(angle);
		var _is_fast = abs(spd_ground) >= PARAM_SKID_SPEED_THRESHOLD;
		
		// Set static animation
		if (_angle_quad == QUADRANT.DOWN && spd_ground == 0)
		{
			if (input_down.up)
			{
				animation = ANIM.LOOKUP;
			}
			else if (input_down.down)
			{
				animation = ANIM.DUCK;
			}
			else if (animation != ANIM.WAIT)
			{
				animation = ANIM.IDLE;
			}
			
			set_push_anim_by = noone;
		}
		
		// Set move or skid animation
		else if (animation != ANIM.SKID)
		{
			if (_is_braking && _is_fast && _angle_quad == QUADRANT.DOWN)
			{
				skid_timer = 0;
				animation = ANIM.SKID;
				audio_play_sfx(snd_skid);
			}
			else if (animation != ANIM.PUSH && animation != ANIM.FLIP)
			{
				animation = ANIM.MOVE;
			}
		}
	}
	
	if (!input_down.left && !input_down.right)
	{
		if (spd_ground > 0)
		{
			spd_ground = max(spd_ground - frc, 0);
		}
		else if (spd_ground < 0)
		{
			spd_ground = min(spd_ground + frc, 0);
		}
	}

	self.set_velocity();
}