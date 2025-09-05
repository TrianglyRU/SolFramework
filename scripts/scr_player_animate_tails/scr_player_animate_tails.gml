/// @self obj_player
/// @function scr_player_animate_tails()
function scr_player_animate_tails()
{
	switch (animation)
	{
		case ANIM.IDLE:
			obj_set_anim(spr_tails_idle, 8, 0, set_wait_anim);	
		break;
		
		case ANIM.WAIT:
			obj_set_anim(spr_tails_wait, 8, 0, 0);
		break;
		
		case ANIM.MOVE:
		
			var _move_sprite = spr_tails_walk;	
			
			if (abs(spd_ground) >= 6)
			{
				_move_sprite = abs(spd_ground) < 10 ? spr_tails_run : spr_tails_dash;
			}
			
			obj_set_anim(_move_sprite, floor(max(1, 9 - abs(spd_ground))), 0, 0);
			
		break;
		
		case ANIM.SPIN:
			obj_set_anim(spr_tails_spin, 2, 0, 0);
		break;
		
		case ANIM.SPINDASH:
			obj_set_anim(spr_tails_spindash, 1, 0, 0);
		break;
		
		case ANIM.PUSH:
			obj_set_anim(spr_tails_push, floor(max(1, 9 - abs(spd_ground)) * 4), 0, 0);
		break;
		
		case ANIM.DUCK:
			obj_set_anim(spr_tails_duck, 0, 0, 0);
		break;
		
		case ANIM.LOOKUP:
			obj_set_anim(spr_tails_lookup, 0, 0, 0);
		break;
		
		case ANIM.GRAB:
			obj_set_anim(spr_tails_grab, 20, 0, 0);
		break;
		
		case ANIM.HURT:
			obj_set_anim(spr_tails_hurt, 0, 0, 0);
		break;
		
		case ANIM.DEATH:
		case ANIM.DROWN:
			obj_set_anim(spr_tails_death, 0, 0, 0);
		break;
		
		case ANIM.SKID:
			obj_set_anim(spr_tails_skid, 8, 0, set_move_anim);		
		break;
		
		case ANIM.TRANSFORM:
			obj_set_anim(spr_tails_transform, 3, 0, set_move_anim);
		break;
		
		case ANIM.BREATHE:
			obj_set_anim(spr_tails_breathe, 24, 0, set_move_anim);
		break;
		
		case ANIM.BOUNCE:
			obj_set_anim(spr_tails_bounce, 4, 0, set_move_anim);
		break;
		
		case ANIM.BALANCE:
			obj_set_anim(spr_tails_balance, 20, 0, 0);
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			obj_set_anim(spr_tails_flip, 1, 0, end_flip_anim);
			
			// Override the displayed sprite
			if (facing == -1)
			{
				sprite_index = spr_tails_flip_flipped;
			}
			
		break;
		
		case ANIM.FLY:
		
			if (carry_target == noone)
			{
				obj_set_anim(spr_tails_fly, 0, 0, 0);
			}
			else
			{
				obj_set_anim(spr_tails_fly_carry, 0, 0, 0); image_index = vel_y <= 0 ? 1 : 0;
			}
			
		break;
		
		case ANIM.FLY_TIRED:
			obj_set_anim(carry_target == noone ? spr_tails_fly_tired : spr_tails_fly_carry_tired, 8, 0, 0);
		break;
		
		case ANIM.SWIM:
			
			if (carry_target == noone)
			{
				obj_set_anim(spr_tails_swim, vel_y <= 0 ? 4 : 8, 0, 0);
			}
			else
			{
				obj_set_anim(spr_tails_swim_carry, 8, 0, 0);
			}
		
		break;
		
		case ANIM.SWIM_TIRED:
			obj_set_anim(spr_tails_swim_tired, 8, 0, 0);
		break;
		
		case ANIM.SWIM_CARRY:
			obj_set_anim(spr_tails_swim_carry, 8, 0, 0);
		break;
	}
}