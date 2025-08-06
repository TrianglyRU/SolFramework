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
		var _do_skid = false;
		if (input_down.left)
		{	
			if (spd_ground > 0)
			{
				spd_ground -= dec;
				if (spd_ground < 0)
				{
					spd_ground = -0.5;
				}
				
				_do_skid = true;
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
				
				_do_skid = true;
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
				
				if (animation == ANIM.SKID)
				{
					animation = ANIM.MOVE;
				}
			}
		}
		
		if (set_push_anim_by != noone && anim_frame_change_flag)
		{
			animation = ANIM.PUSH;
		}

		var _angle_quad = math_get_quadrant(angle);
		if (_angle_quad != QUADRANT.DOWN || spd_ground != 0)
		{
			if (animation != ANIM.SKID && animation != ANIM.PUSH && animation != ANIM.FLIP)
			{
				animation = ANIM.MOVE;
			}
			
			if (animation != ANIM.SKID && _angle_quad == QUADRANT.DOWN && _do_skid && abs(spd_ground) >= PARAM_SKID_SPEED_THRESHOLD )
			{
				skid_timer = 0;
				animation = ANIM.SKID;
				audio_play_sfx(snd_skid);
			}
		}
		else
		{
			if (input_down.up)
			{
				animation = ANIM.LOOKUP;
			}
			else if (input_down.down)
			{
				animation = ANIM.DUCK;
			}
			else
			{
				animation = ANIM.IDLE;
			}
			
			set_push_anim_by = noone;
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

	set_velocity();
}