/// @self obj_player
/// @function scr_player_animate_knuckles()
function scr_player_animate_knuckles()
{
	gml_pragma("forceinline");
	
	switch (animation)
	{
		case ANIM.IDLE:
		
			obj_set_anim(spr_knuckles_idle, 300, 0, function()
			{ 
				animation = ANIM.WAIT 
			});
			
		break;
		
		case ANIM.WAIT:
			
			obj_set_anim(spr_knuckles_wait, 6, 0, function() 
			{ 
				animation = ANIM.IDLE 
			});
			
		break;
		
		case ANIM.MOVE:
			obj_set_anim(abs(spd_ground) < 6 ? spr_knuckles_walk : spr_knuckles_run, floor(max(1, 9 - abs(spd_ground))), 0, 0);
		break;
		
		case ANIM.SPIN:
			obj_set_anim(spr_knuckles_spin, floor(max(1, 5 - abs(spd_ground))), 0, 0);	
		break;
		
		case ANIM.SPINDASH:
			obj_set_anim(spr_knuckles_spindash, 1, 0, 0);
		break;
		
		case ANIM.PUSH:
			obj_set_anim(spr_knuckles_push, floor(max(1, 9 - abs(spd_ground))), 0, 0); 
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
		
			obj_set_anim(spr_knuckles_skid, 4, 0, function()
			{ 
				animation = ANIM.MOVE; 
			});
			
		break;
		
		case ANIM.TRANSFORM:
		
			obj_set_anim(spr_knuckles_transform, 3, 0, function()
			{ 
				animation = ANIM.MOVE; 
			});
			
		break;
		
		case ANIM.BREATHE:
		
			obj_set_anim(spr_knuckles_breathe, 24, 0, function()
			{ 
				animation = ANIM.MOVE; 
			});
			
		break;
		
		case ANIM.BOUNCE:
		
			obj_set_anim(spr_knuckles_bounce, 48, 0, function()
			{ 
				animation = ANIM.MOVE; 
			});
			
		break;
		
		case ANIM.BALANCE:
		case ANIM.BALANCE_FLIP:
			obj_set_anim(spr_knuckles_balance, 4, animation == ANIM.BALANCE_FLIP ? 4 : 0, 33);	
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			obj_set_anim(spr_knuckles_flip, 1, 0, function()
			{
				if (animation == ANIM.FLIP || anim_play_count == 2)
				{
					animation = ANIM.MOVE;
				}; 
			});
			
			// Override the displayed sprite
			if (facing == DIRECTION.NEGATIVE)
			{
				sprite_index = spr_knuckles_flip_flipped;
			}
			
		break;
		
		case ANIM.GLIDE_AIR:
		
			obj_set_anim(spr_knuckles_glide, 0, 0, 0);
			
			// Override the displayed frame
			var _angle = abs(glide_angle) % 180;
	        if (_angle < 30 || _angle > 150)
	        {
	            image_index = 0;
	        }
	        else if (_angle < 60 || _angle > 120)
	        {
	            image_index = 1;
	        }
	        else
	        {
				image_index = 2;
			}
			
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