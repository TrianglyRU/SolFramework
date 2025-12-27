/// @self obj_player
function scr_player_update_hitbox()
{
	switch player_type
	{
		case PLAYER.SONIC:
		
			if animation == ANIM.DUCK && global.player_physics < PHYSICS.S3
			{
				mask_index = spr_sonic_duck;
			}
			else if animation == ANIM.SPIN
			{
				mask_index = spr_sonic_spin;
			}
			else
			{
				mask_index = spr_sonic_idle;
			}
			
		break;
		
		case PLAYER.TAILS:
			mask_index = animation != ANIM.SPIN ? spr_tails_idle : spr_tails_spin;
		break;
		
		case PLAYER.KNUCKLES:
		
			if animation == ANIM.DUCK && global.player_physics < PHYSICS.S3
			{
				mask_index = spr_knuckles_duck;
			}
			else if animation == ANIM.SPIN
			{
				mask_index = spr_knuckles_spin;
			}
			else if animation == ANIM.GLIDE_AIR || animation == ANIM.CLIMB_LEDGE || animation == ANIM.CLIMB_WALL
			{
				mask_index = spr_knuckles_glide;
			}
			else
			{
				mask_index = spr_knuckles_idle;	
			}
			
		break;
		
		case PLAYER.AMY:
			mask_index = animation != ANIM.SPIN ? spr_amy_idle : spr_amy_spin;
		break;
	}
	
	if action == ACTION.HAMMERSPIN
	{
		extra_mask = spr_amy_spin_hammer;
	}
	else if animation == ANIM.HAMMERDASH
	{
		switch image_index % 4
		{
			case 0: extra_mask = spr_mask_amy_attack_1; break;
			case 1: extra_mask = spr_mask_amy_attack_2; break;
			case 2: extra_mask = spr_mask_amy_attack_3; break;
			case 3: extra_mask = spr_mask_amy_attack_4; break;
		}
	}
	else if shield_state == SHIELD_STATE.DOUBLE_SPIN
	{
		extra_mask = spr_mask_sonic_attack;
	}
	else
	{
		extra_mask = mask_index;
	}
}