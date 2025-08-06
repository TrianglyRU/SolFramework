/// @self obj_player
/// @function scr_player_animate_amy()
function scr_player_animate_amy()
{
	gml_pragma("forceinline");
	
	switch animation
	{
		case ANIM.IDLE:
		case ANIM.WAIT:
			
			obj_set_anim(spr_amy_idle, 2, 0, 120);
			
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
			
			obj_set_anim(_move_sprite, floor(max(1, 9 - abs(spd_ground))), 0, 0);
			
		break;
			
		case ANIM.SPIN:
		
			obj_set_anim(spr_amy_spin, floor(max(1, 5 - abs(spd_ground))), image_index, 0);
			
			// Override the displayed sprite
			if (action == ACTION.HAMMERSPIN)
			{
				sprite_index = spr_amy_spin_hammer;
			}
			
		break;
		
		case ANIM.SPINDASH:	
			obj_set_anim(spr_amy_spindash, 1, 0, 0);
		break;
		
		case ANIM.PUSH:
			obj_set_anim(spr_amy_push, floor(max(1, 9 - abs(spd_ground)) * 4), 0, 0);	
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
			obj_set_anim(spr_amy_transform, 3, 0, function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BREATHE:
			obj_set_anim(spr_amy_breathe, 24, 0, function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BOUNCE:
			obj_set_anim(spr_amy_bounce, 4, 0, function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BALANCE:
			obj_set_anim(spr_amy_balance, 8, 0, 0);
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			obj_set_anim(spr_amy_flip, 1, 0, function()
			{
				if (animation == ANIM.FLIP || anim_play_count > 1)
				{
					animation = ANIM.MOVE;
				}; 
			});
			
			// Override the displayed sprite
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