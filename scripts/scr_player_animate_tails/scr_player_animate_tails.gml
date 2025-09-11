/// @self obj_player
function scr_player_animate_tails()
{
	switch animation
	{
		case ANIM.IDLE:
			
			if sprite_index != spr_tails_idle
			{
				animator.start(spr_tails_idle, 0, 30, 8);
			}
			else if animator.timer < 0
			{
				animation = ANIM.WAIT;
				animator.start(spr_tails_wait, 0, 0, 8);
			}
			
		break;
		
		case ANIM.MOVE:
		
			var _move_sprite = spr_tails_walk;	
			var _move_timing = floor(max(1, 9 - abs(spd_ground)));
			
			if abs(spd_ground) >= 6
			{
				_move_sprite = abs(spd_ground) < 10 ? spr_tails_run : spr_tails_dash;
			}
			
			if sprite_index != _move_sprite
			{
				animator.start(_move_sprite, 0, 0, _move_timing);
			}
			else
			{
				animator.duration = _move_timing;
			}
			
		break;
		
		case ANIM.SPIN:
		
			if sprite_index != spr_tails_spin
			{
				animator.start(spr_tails_spin, 0, 0, 2);
			}
			
		break;
		
		case ANIM.SPINDASH:
		
			if sprite_index != spr_tails_spindash
			{
				animator.start(spr_tails_spindash, 0, 0, 1);
			}
			
		break;
		
		case ANIM.PUSH:
		
			var _push_timing = floor(max(1, 9 - abs(spd_ground)) * 4);
		
			if sprite_index != spr_tails_push
			{
				animator.start(spr_tails_push, 0, 0, _push_timing);
			}
			else
			{
				animator.duration = _push_timing;
			}
			
		break;
		
		case ANIM.DUCK:
			sprite_index = spr_tails_duck;
		break;
		
		case ANIM.LOOKUP:
			sprite_index = spr_tails_lookup;
		break;
		
		case ANIM.GRAB:
		
			if sprite_index != spr_tails_grab
			{
				animator.start(spr_tails_grab, 0, 0, 20);
			}
			
		break;
		
		case ANIM.HURT:
			sprite_index = spr_tails_hurt;
		break;
		
		case ANIM.DEATH:
		case ANIM.DROWN:
			sprite_index = spr_tails_death;
		break;
		
		case ANIM.SKID:
		
			if sprite_index != spr_tails_skid
			{
				animator.start(spr_tails_skid, 0, 2, 8);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
					
		break;
		
		case ANIM.TRANSFORM:
			
			if sprite_index != spr_tails_transform
			{
				animator.start(spr_tails_transform, 0, 11, 3);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BREATHE:
		
			if sprite_index != spr_tails_breathe
			{
				animator.start(spr_tails_breathe, 0, 0, 24);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BOUNCE:
		
			if sprite_index != spr_tails_bounce
			{
				animator.start(spr_tails_bounce, 0, 11, 4);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BALANCE:
			
			if sprite_index != spr_tails_balance
			{
				animator.start(spr_tails_balance, 0, 0, 20);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			var _flip_sprite = facing >= 0 ? spr_tails_flip : spr_tails_flip_flipped;
			
			if sprite_index != spr_tails_flip && sprite_index != spr_tails_flip_flipped
			{
				animator.start(_flip_sprite, 0, 61, 1);
			}
			else
			{
				if animator.timer < 0
				{
					if animation == ANIM.FLIP_EXTENDED && animator.play_count < 2
					{
						animator.timer = animator.duration;
						image_index = 0;
					}
					else
					{
						animation = ANIM.MOVE;
					}
				}
				
				sprite_index = _flip_sprite;
			}
			
		break;
		
		case ANIM.FLY:
			
			if carry_target == noone
			{
				sprite_index = spr_tails_fly;
			}
			else
			{
				sprite_index = spr_tails_fly_carry;
				image_index = vel_y <= 0 ? 1 : 0;
			}
			
		break;
		
		case ANIM.FLY_TIRED:
			
			var _tired_sprite = carry_target == noone ? spr_tails_fly_tired : spr_tails_fly_carry_tired;
			
			if sprite_index != spr_tails_fly_tired && sprite_index != spr_tails_fly_carry_tired
			{
				animator.start(_tired_sprite, 0, 0, 8);
			}
			else
			{
				sprite_index = _tired_sprite;
			}
			
		break;
		
		case ANIM.SWIM:
			
			if carry_target == noone
			{
				var _swim_timing = vel_y <= 0 ? 4 : 8;
				
				if sprite_index != spr_tails_swim
				{
					animator.start(spr_tails_swim, 0, 0, _swim_timing);	
				}
				else
				{
					animator.duration = _swim_timing;	
				}
			}
			else if sprite_index != spr_tails_swim_carry
			{
				animator.start(spr_tails_swim_carry, 0, 0, 8);
			}
			
		break;
		
		case ANIM.SWIM_TIRED:
			
			if sprite_index != spr_tails_swim_tired
			{
				animator.start(spr_tails_swim_tired, 0, 0, 8);
			}
			
		break;
		
		case ANIM.SWIM_CARRY:
		
			if sprite_index != spr_tails_swim_carry
			{
				animator.start(spr_tails_swim_carry, 0, 0, 8);
			}
			
		break;
	}
}