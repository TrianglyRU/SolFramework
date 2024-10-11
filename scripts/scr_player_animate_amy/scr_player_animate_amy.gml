/// @function scr_player_animate_amy()
/// @self obj_player
function scr_player_animate_amy()
{
	gml_pragma("forceinline");
	
	switch animation
	{
		case ANIM.IDLE:
		case ANIM.WAIT:
			
			var _idle_order_data =
			[
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				1, 1, 1, 1, 1, 1, 1, 1,
				2, 2, 2, 2, 2,
				3, 3, 3, 3, 3, 3, 3, 3,
				2, 2, 2, 2, 2
			];
			
			obj_set_anim(spr_amy_idle, 2, _idle_order_data, 120);
			
			if (image_index > 0)
			{
				animation = ANIM.WAIT;
			}
			
		break;
			
		case ANIM.MOVE:
		
			var _move_sprite = spr_amy_walk;
			
			if (abs(spd_ground) >= 6)
			{
				_move_sprite = abs(spd_ground) < 10 ? spr_amy_run : spr_amy_dash;
			}
			
			obj_set_anim(_move_sprite, floor(max(1, 9 - abs(spd_ground))), 0, 0, true);
			
		break;
			
		case ANIM.SPIN:
		
			var _spin_duration = floor(max(1, 5 - abs(spd_ground)));
			
			if (action == ACTION.HAMMERSPIN)
			{
				obj_set_anim(spr_amy_spin_hammer, _spin_duration, anim_order_index, 0, true);
			}
			else
			{
				obj_set_anim(spr_amy_spin, _spin_duration, [0, 4, 1, 4, 2, 4, 3, 4], 0, true);
			}
			
		break;
		
		case ANIM.SPINDASH:	
			obj_set_anim(spr_amy_spindash, 1, [0, 5, 1, 5, 2, 5, 3, 5, 4, 5], 0);
		break;
		
		case ANIM.PUSH:
			obj_set_anim(spr_amy_push, floor(max(1, 9 - abs(spd_ground)) * 4), 0, 0, true);	
		break;
		
		case ANIM.DUCK:	
			obj_set_anim(spr_amy_duck, 4, 0, 1);
		break;
		
		case ANIM.LOOKUP:	
			obj_set_anim(spr_amy_lookup, 4, 0, 1);
		break;
		
		case ANIM.GRAB:	
			obj_set_anim(spr_amy_grab, 20, 0, 0);
		break;
		
		case ANIM.HURT:	
			obj_set_anim(spr_amy_hurt, 0, 0, 0);
		break;
		
		case ANIM.DEATH:	
			obj_set_anim(spr_amy_death, 0, 0, 0);
		break;
		
		case ANIM.DROWN:
			obj_set_anim(spr_amy_drown, 0, 0, 0);
		break;
		
		case ANIM.SKID:
			obj_set_anim(spr_amy_skid, 6, 0, 3);
		break;
		
		case ANIM.TRANSFORM:
			
			var _transform_order_data =
			[
				0, 0, 1, 1, 2, 3, 2, 3, 2, 3, 2, 3
			];
			
			obj_set_anim(spr_amy_transform, 3, _transform_order_data, function(){ animation = ANIM.MOVE; });
			
		break;
		
		case ANIM.BREATHE:
			obj_set_anim(spr_amy_breathe, 24, 0, function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BOUNCE:
			obj_set_anim(spr_amy_bounce, 4, [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1], function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BALANCE:
			obj_set_anim(spr_amy_balance, 8, 0, 0);
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			obj_set_anim(spr_amy_flip, 1, get_flip_order_data(), function(){ animation = ANIM.MOVE; });
			
			if (facing == DIRECTION.NEGATIVE)
			{
				sprite_index = spr_amy_flip_flipped;
			}
			
		break;
		
		case ANIM.HAMMERDASH:
			obj_set_anim(spr_amy_dash_hammer, 3, 0, 0);
		break;
	}
}