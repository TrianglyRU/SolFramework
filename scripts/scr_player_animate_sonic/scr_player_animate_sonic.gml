/// @self obj_player
/// @function scr_player_animate_sonic()
function scr_player_animate_sonic()
{
	switch animation
	{
		case ANIM.IDLE:
			
			if super_timer > 0
			{
				if sprite_index != spr_sonic_idle_super
				{
					instance_animation_start(spr_sonic_idle_super, 0, 0, 8);
				}
			}
			else if sprite_index != spr_sonic_idle
			{
				instance_animation_start(spr_sonic_idle, 0, 0, 180);
			}
			else if image_timer == -1
			{
				animation = ANIM.WAIT;
				instance_animation_start(spr_sonic_wait, 0, 6, 6);
			}
			
		break;
		
		case ANIM.MOVE:
		
			var _move_sprite;
			var _move_timing = floor(max(1, 9 - abs(spd_ground)));
			
			if super_timer > 0
			{
				_move_sprite = abs(spd_ground) < 8 ? spr_sonic_walk_super : spr_sonic_dash_super;
			}
			else if (abs(spd_ground) >= 6)
			{
				_move_sprite = abs(spd_ground) < 10 || !global.dash ? spr_sonic_run : spr_sonic_dash;
			}
			else
			{
				_move_sprite = spr_sonic_walk;
			}
			
			if sprite_index != _move_sprite
			{
				instance_animation_start(_move_sprite, 0, 0, _move_timing);
			}
			else
			{
				image_duration = _move_timing;
			}
			
			if sprite_index == spr_sonic_walk_super && obj_game.frame_counter % 4 <= 1
			{
				image_index = (image_index + floor(image_number * 0.5)) % image_number;
			}
			
		break;
			
		case ANIM.SPIN:
		
			if action == ACTION.DROPDASH && dropdash_charge >= PARAM_DROPDASH_CHARGE
			{
				if sprite_index != spr_sonic_dropdash
				{
					instance_animation_start(spr_sonic_dropdash, 0, 0, 1);
				}
			}
			else 
			{
				var _spin_timing = floor(max(1, 5 - abs(spd_ground)));
				
				if sprite_index != spr_sonic_spin
				{
					instance_animation_start(spr_sonic_spin, 0, 0, _spin_timing);
				}
				else
				{
					image_duration = _spin_timing;
				}
			}
			
		break;
		
		case ANIM.SPINDASH:
			
			if sprite_index != spr_sonic_spindash
			{
				instance_animation_start(spr_sonic_spindash, 0, 0, 1);
			}
			
		break;
		
		case ANIM.PUSH:
			
			var _push_sprite = super_timer > 0 ? spr_sonic_push_super : spr_sonic_push;
			var _push_timing = floor(max(1, 9 - abs(spd_ground)) * 4);
			
			if sprite_index != _push_sprite
			{
				instance_animation_start(_push_sprite, 0, 0, _push_timing);
			}
			else
			{
				image_duration = _push_timing;
			}
			
		break;
		
		case ANIM.DUCK:
			
			if super_timer > 0
			{
				sprite_index = spr_sonic_duck_super;
				image_index = 0;
			}
			else if sprite_index != spr_sonic_duck
			{
				instance_animation_start(spr_sonic_duck, 0, 1, 4);
			}
			
		break;
		
		case ANIM.LOOKUP:
		
			if sprite_index != spr_sonic_lookup
			{
				instance_animation_start(spr_sonic_lookup, 0, 1, 4);
			}
			
		break;
		
		case ANIM.GRAB:
			
			if sprite_index != spr_sonic_grab
			{
				instance_animation_start(spr_sonic_grab, 0, 0, 20);
			}
			
		break;
		
		case ANIM.HURT:
			sprite_index = spr_sonic_hurt;
		break;
		
		case ANIM.DEATH:
			sprite_index = spr_sonic_death;
		break;
		
		case ANIM.DROWN:
			sprite_index = spr_sonic_drown;	
		break;
		
		case ANIM.SKID:
		
			if sprite_index != spr_sonic_skid
			{
				instance_animation_start(spr_sonic_skid, 0, 3, 6);
			}
			else if image_timer == -1
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.TRANSFORM:
		
			if sprite_index != spr_sonic_transform
			{
				instance_animation_start(spr_sonic_transform, 0, 12, 3);
			}
			else if image_timer == -1
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BREATHE:
		
			if sprite_index != spr_sonic_breathe
			{
				instance_animation_start(spr_sonic_breathe, 0, 0, 24);
			}
			else if image_timer == -1
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BOUNCE:
		
			if sprite_index != spr_sonic_bounce
			{
				instance_animation_start(spr_sonic_bounce, 0, 0, 48);
			}
			else if image_timer == -1
			{
				animation = ANIM.MOVE;
			}
			
		break;
			
		case ANIM.BALANCE:
			
			var _balance_sprite = super_timer > 0 ? spr_sonic_balance_super : spr_sonic_balance;
			
			if sprite_index != _balance_sprite
			{
				instance_animation_start(_balance_sprite, 0, 0, 10);
			}
			
		break;
		
		case ANIM.BALANCE_FLIP:
			
			if sprite_index != spr_sonic_balance_flip
			{
				instance_animation_start(spr_sonic_balance_flip, 0, 0, 20);
			}
			
		break;
		
		case ANIM.BALANCE_PANIC:
		
			if sprite_index != spr_sonic_balance_panic
			{
				instance_animation_start(spr_sonic_balance_panic, 0, 0, 4);
			}
			
		break;
		
		case ANIM.BALANCE_TURN:
			sprite_index = spr_sonic_balance_turn;
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			var _flip_sprite = image_xscale >= 0 ? spr_sonic_flip : spr_sonic_flip_flipped;
			
			if sprite_index != spr_sonic_flip && sprite_index != spr_sonic_flip_flipped
			{
				instance_animation_start(_flip_sprite, 0, 0, 1);
			}
			else
			{
				if anim_timer == -1
				{
					animation = ANIM.MOVE;
				}
				
				sprite_index = _flip_sprite;
			}
			
		break;
	}
}