/// @self obj_player
/// @function scr_player_animate_amy()
function scr_player_animate_amy()
{
	gml_pragma("forceinline");
	
	switch (animation)
	{
		case ANIM.IDLE:
			obj_set_anim(spr_amy_idle, 240, 0, set_wait_anim);	
		break;
		
		case ANIM.WAIT:
			
			if (sprite_index != spr_amy_wait_2)
			{
				obj_set_anim(spr_amy_wait, 2, 0, 0);
				
				if (anim_play_count == 16)
				{
					obj_set_anim(spr_amy_wait_2, 2, 0, 18);
				}
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
			obj_set_anim(spr_amy_skid, 6, 0, set_move_anim);	
		break;
		
		case ANIM.TRANSFORM:
			obj_set_anim(spr_amy_transform, 3, 0, set_move_anim);
		break;
		
		case ANIM.BREATHE:
			obj_set_anim(spr_amy_breathe, 24, 0, set_move_anim);	
		break;
		
		case ANIM.BOUNCE:
			obj_set_anim(spr_amy_bounce, 4, 0, set_move_anim);
		break;
		
		case ANIM.BALANCE:
			obj_set_anim(spr_amy_balance, 8, 0, 0);
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			obj_set_anim(spr_amy_flip, 1, 0, end_flip_anim);
			
			// Override the displayed sprite
			if (facing == -1)
			{
				sprite_index = spr_amy_flip_flipped;
			}
			
		break;
		
		case ANIM.HAMMERDASH:
			obj_set_anim(spr_amy_dash_hammer, 3, 0, 0);
		break;
	}
}