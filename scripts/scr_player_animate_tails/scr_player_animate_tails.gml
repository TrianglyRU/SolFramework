/// @function scr_player_animate_tails()
/// @self obj_player
function scr_player_animate_tails()
{
	gml_pragma("forceinline");
	
	switch (animation)
	{
		case ANIM.IDLE:
		case ANIM.WAIT:
			
			var _idle_order_data =
			[
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				1, 2, 
				0, 0, 0, 0, 0, 0, 0, 0, 
				1, 2,
				0, 0, 0, 0, 0, 0, 0, 0, 0,
				3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
				4, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 4,
			];
			
			obj_set_anim(spr_tails_idle, 8, _idle_order_data, 32);
			
			if (image_index > 2)
			{
				animation = ANIM.WAIT;
			}
			
		break;
		
		case ANIM.MOVE:
		
			var _move_sprite = spr_tails_walk;
			
			if (abs(spd_ground) >= 6)
			{
				_move_sprite = abs(spd_ground) < 10 ? spr_tails_run : spr_tails_dash;
			}
			
			obj_set_anim(_move_sprite, floor(max(1, 9 - abs(spd_ground))), 0, 0, true);
			
		break;
		
		case ANIM.SPIN:
			obj_set_anim(spr_tails_spin, 2, 0, 0);
		break;
		
		case ANIM.SPINDASH:
			obj_set_anim(spr_tails_spindash, 1, 0, 0);
		break;
		
		case ANIM.PUSH:
			obj_set_anim(spr_tails_push, floor(max(1, 9 - abs(spd_ground)) * 4), 0, 0, true);
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
			obj_set_anim(spr_tails_skid, 8, 0, 1);
		break;
		
		case ANIM.TRANSFORM:
			obj_set_anim(spr_tails_transform, 3, [0, 0, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2], function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BREATHE:
			obj_set_anim(spr_tails_breathe, 24, 0, function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BOUNCE:
			obj_set_anim(spr_tails_bounce, 4, [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1], function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BALANCE:
			obj_set_anim(spr_tails_balance, 20, 0, 0);
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			obj_set_anim(spr_tails_flip, 1, get_flip_order_data(), function(){ animation = ANIM.MOVE; });
			
			if (facing == DIRECTION.NEGATIVE)
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
			obj_set_anim(carry_target == noone ? spr_tails_fly_tired : spr_tails_fly_carry_tired, 8);
		break;
		
		case ANIM.SWIM:
			
			if (carry_target == noone)
			{
				obj_set_anim(spr_tails_swim, vel_y <= 0 ? 4 : 8, 0, 0, true);
			}
			else
			{
				obj_set_anim(spr_tails_swim_carry, 8, 0, 0);
			}
		
		break;
		
		case ANIM.SWIM_TIRED:
			obj_set_anim(spr_tails_swim_tired, 8);
		break;
		
		case ANIM.SWIM_CARRY:
			obj_set_anim(spr_tails_swim_carry, 8);
		break;
	}
}