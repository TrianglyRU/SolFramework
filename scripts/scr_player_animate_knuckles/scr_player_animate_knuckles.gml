/// @function scr_player_animate_knuckles()
/// @self obj_player
function scr_player_animate_knuckles()
{
	gml_pragma("forceinline");
	
	switch animation
	{
		case ANIM.IDLE:
		case ANIM.WAIT:
			
			var _idle_order_data =
			[
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 
				2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 
				3, 3, 3, 3, 3, 4,
				5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8,
				9, 10, 9, 10, 11, 11,
				5, 4
			];
			
			obj_set_anim(spr_knuckles_idle, 6, _idle_order_data, 0);
			
			if (image_index > 0)
			{
				animation = ANIM.WAIT;
			}
			
		break;
		
		case ANIM.MOVE:
			obj_set_anim(abs(spd_ground) < 6 ? spr_knuckles_walk : spr_knuckles_run, floor(max(1, 9 - abs(spd_ground))), 0, 0, true);
		break;
		
		case ANIM.SPIN:
			obj_set_anim(spr_knuckles_spin, floor(max(1, 5 - abs(spd_ground))), [0, 4, 1, 4, 2, 4, 3, 4], 0, true);	
		break;
		
		case ANIM.SPINDASH:
			obj_set_anim(spr_knuckles_spindash, 1, [0, 5, 1, 5, 2, 5, 3, 5, 4, 5], 0);
		break;
		
		case ANIM.PUSH:
			obj_set_anim(spr_knuckles_push, floor(max(1, 9 - abs(spd_ground))), 0, 0, true); 
		break;
		
		case ANIM.DUCK:
			obj_set_anim(spr_knuckles_duck, 6, 0, 1);
		break;
		
		case ANIM.LOOKUP:
			obj_set_anim(spr_knuckles_lookup, 6, 0, 1);
		break;
		
		case ANIM.GRAB:
			obj_set_anim(spr_knuckles_grab, 0, 0, 0);
		break;
		
		case ANIM.HURT:
			obj_set_anim(spr_knuckles_hurt, 0, 0, 0);
		break;
		
		case ANIM.DEATH:
			obj_set_anim(spr_knuckles_death, 0, 0, 0);
		break;
		
		case ANIM.DROWN:
			obj_set_anim(spr_knuckles_drown, 0, 0, 0);
		break;
		
		case ANIM.SKID:
			obj_set_anim(spr_knuckles_skid, 4, [0, 1, 1, 2], 3);
		break;
		
		case ANIM.TRANSFORM:
			obj_set_anim(spr_knuckles_transform, 3, [0, 0, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2], function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BREATHE:
			obj_set_anim(spr_knuckles_breathe, 24, 0, function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BOUNCE:
			obj_set_anim(spr_knuckles_bounce, 48, 0, function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BALANCE:
		case ANIM.BALANCE_FLIP:
		
			var _balance_order_data =
			[
				0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 6, 6, 6, 6,
				6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 10, 10, 11, 11
			];
			
			obj_set_anim(spr_knuckles_balance, 4, _balance_order_data, 0, 33);
			
			if (animation == ANIM.BALANCE_FLIP && image_index < 2)
			{
				obj_set_order_frame(2);
			}
			
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			obj_set_anim(spr_knuckles_flip, 1, get_flip_order_data(), function(){ animation = ANIM.MOVE; });
			
			if (facing == DIRECTION.NEGATIVE)
			{
				sprite_index = spr_knuckles_flip_flipped;
			}
			
		break;
		
		case ANIM.GLIDE_AIR:
			obj_set_anim(spr_knuckles_glide, 0, 0, 0);
		break;
		
		case ANIM.GLIDE_FALL:
			obj_set_anim(spr_knuckles_glide_fall, 6, glide_value, 1);
		break;
		
		case ANIM.GLIDE_GROUND:
			obj_set_anim(spr_knuckles_slide, 0, 0, 0);
		break;
		
		case ANIM.GLIDE_LAND:
			obj_set_anim(spr_knuckles_duck, 6, 1, 1);
		break;
		
		case ANIM.CLIMB_WALL:
			obj_set_anim(spr_knuckles_climb, 0, 0, 0);
		break;
		
		case ANIM.CLIMB_LEDGE:
			obj_set_anim(spr_knuckles_climb_ledge, 6, 0, 2);
		break;
	}
}