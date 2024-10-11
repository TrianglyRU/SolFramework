/// @function scr_player_animate_sonic()
/// @self obj_player
function scr_player_animate_sonic()
{
	gml_pragma("forceinline");
	
	switch (animation)
	{
		case ANIM.IDLE:
		case ANIM.WAIT:
		
			if (super_timer > 0)
			{
				obj_set_anim(spr_sonic_idle_super, 8, 0, 0);
				break;
			}
			
			var _idle_order_data =
			[
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				1,
				2, 2, 2, 2, 2,
				3, 3, 3, 4, 4, 4, 3, 3, 3, 4, 4, 4, 3, 3, 3, 4, 4, 4,
				5, 5, 5, 5, 5, 5, 5, 5, 5
			];
			
			obj_set_anim(spr_sonic_idle, 6, _idle_order_data, 36);
			
			if (image_index > 0)
			{
				animation = ANIM.WAIT;
			}
			
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
			
			obj_set_anim(_move_sprite, floor(max(1, 9 - abs(spd_ground))), 0, 0, true);
			
			if (_move_sprite == spr_sonic_walk_super && obj_framework.frame_counter % 4 <= 1)
			{
				image_index = (image_index + floor(image_number / 2)) % image_number;
			}
			
		break;
		
		case ANIM.SPIN:
		
			if (action == ACTION.DROPDASH && dropdash_charge >= PARAM_DROPDASH_CHARGE)
			{
				obj_set_anim(spr_sonic_dropdash, 1, 0, 0);
			}
			else
			{
				obj_set_anim(spr_sonic_spin, floor(max(1, 5 - abs(spd_ground))), [0, 4, 1, 4, 2, 4, 3, 4], 0, true);
			}
			
		break;
		
		case ANIM.SPINDASH:
			obj_set_anim(spr_sonic_spindash, 1, [0, 5, 1, 5, 2, 5, 3, 5, 4, 5], 0);
		break;
		
		case ANIM.PUSH:
			obj_set_anim(super_timer > 0 ? spr_sonic_push_super : spr_sonic_push, floor(max(1, 9 - abs(spd_ground)) * 4), 0, 0, true);
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
			obj_set_anim(spr_sonic_skid, 6, 0, 3);
		break;
		
		case ANIM.TRANSFORM:
			
			var _transform_order_data =
			[
				0, 0, 1, 1, 2, 3, 4, 3, 4, 3, 4, 3, 4
			];
			
			obj_set_anim(spr_sonic_transform, 3, _transform_order_data, function(){ animation = ANIM.MOVE; });
			
		break;
		
		case ANIM.BREATHE:
			obj_set_anim(spr_sonic_breathe, 24, 0, function(){ animation = ANIM.MOVE; });
		break;
		
		case ANIM.BOUNCE:
			obj_set_anim(spr_sonic_bounce, 48, 0, function(){ animation = ANIM.MOVE; });
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
			
			obj_set_anim(spr_sonic_flip, 1, get_flip_order_data(), function(){ animation = ANIM.MOVE; });
			
			if (facing == DIRECTION.NEGATIVE)
			{
				sprite_index = spr_sonic_flip_flipped;
			}
			
		break;
	}
}