/// @self obj_player
/// @function scr_player_animate_sonic()
function scr_player_animate_sonic()
{
	gml_pragma("forceinline");
	
	switch (animation)
	{
		case ANIM.IDLE:
			
			if (super_timer > 0)
			{
				obj_set_anim(spr_sonic_idle_super, 8, 0, 0);
			}
			else
			{
				obj_set_anim(spr_sonic_idle, 180, 0, self.set_wait_anim);
			}
		
		break;
		
		case ANIM.WAIT:
			obj_set_anim(spr_sonic_wait, 6, 0, 6);
		break;
		
		case ANIM.MOVE:
		
			var _move_sprite = spr_sonic_walk;
			
			if (super_timer > 0)
			{
				_move_sprite = abs(spd_ground) < 8 ? spr_sonic_walk_super : spr_sonic_dash_super;
			}
			else if (abs(spd_ground) >= 6)
			{
				_move_sprite = abs(spd_ground) < 10 || !global.dash ? spr_sonic_run : spr_sonic_dash;
			}
			
			obj_set_anim(_move_sprite, floor(max(1, 9 - abs(spd_ground))), 0, 0);
			
			// Override the displayed frame
			if (_move_sprite == spr_sonic_walk_super && obj_game.frame_counter % 4 <= 1)
			{
				image_index = (image_index + floor(image_number * 0.5)) % image_number;
			}
			
		break;
		
		case ANIM.SPIN:
		
			if (action == ACTION.DROPDASH && dropdash_charge >= PARAM_DROPDASH_CHARGE)
			{
				obj_set_anim(spr_sonic_dropdash, 1, 0, 0);
			}
			else
			{
				obj_set_anim(spr_sonic_spin, floor(max(1, 5 - abs(spd_ground))), 0, 0);
			}
			
		break;
		
		case ANIM.SPINDASH:
			obj_set_anim(spr_sonic_spindash, 1, 0, 0);
		break;
		
		case ANIM.PUSH:
			obj_set_anim(super_timer > 0 ? spr_sonic_push_super : spr_sonic_push, floor(max(1, 9 - abs(spd_ground)) * 4), 0, 0);
		break;
		
		case ANIM.DUCK:
		
			if (super_timer > 0)
			{
				obj_set_anim(spr_sonic_duck_super, 0, 0, 0);
			}
			else
			{
				obj_set_anim(spr_sonic_duck, 4, 0, 1);
			}
			
		break;
		
		case ANIM.LOOKUP:
			obj_set_anim(spr_sonic_lookup, 4, 0, 1);
		break;
		
		case ANIM.GRAB:
			obj_set_anim(spr_sonic_grab, 20, 0, 0);
		break;
		
		case ANIM.HURT:
			obj_set_anim(spr_sonic_hurt, 0, 0, 0);
		break;
		
		case ANIM.DEATH:
			obj_set_anim(spr_sonic_death, 0, 0, 0);
		break;
		
		case ANIM.DROWN:
			obj_set_anim(spr_sonic_drown, 0, 0, 0);
		break;
		
		case ANIM.SKID:
			obj_set_anim(spr_sonic_skid, 6, 0, self.set_move_anim);	
		break;
		
		case ANIM.TRANSFORM:
			obj_set_anim(spr_sonic_transform, 3, 0, self.set_move_anim);	
		break;
		
		case ANIM.BREATHE:
			obj_set_anim(spr_sonic_breathe, 24, 0, self.set_move_anim);	
		break;
		
		case ANIM.BOUNCE:
			obj_set_anim(spr_sonic_bounce, 48, 0, self.set_move_anim);		
		break;
		
		case ANIM.BALANCE:
			obj_set_anim(super_timer > 0 ? spr_sonic_balance_super : spr_sonic_balance, 10, 0, 0);
		break;
		
		case ANIM.BALANCE_FLIP:
			obj_set_anim(spr_sonic_balance_flip, 20, 0, 0);
		break;
		
		case ANIM.BALANCE_PANIC:
			obj_set_anim(spr_sonic_balance_panic, 4, 0, 0);
		break;
		
		case ANIM.BALANCE_TURN:
			obj_set_anim(spr_sonic_balance_turn, 0, 0, 0);
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
		
			obj_set_anim(spr_sonic_flip, 1, 0, self.end_flip_anim);
			
			// Override the displayed sprite
			if (facing == DIRECTION.NEGATIVE)
			{
				sprite_index = spr_sonic_flip_flipped;
			}
			
		break;
	}
}