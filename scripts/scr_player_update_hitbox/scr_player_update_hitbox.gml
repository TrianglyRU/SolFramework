/// @self obj_player
function scr_player_update_hitbox()
{
	switch player_type
	{
		case PLAYER.SONIC:
			mask_index = animation != ANIM.SPIN ? spr_sonic_idle : spr_sonic_spin;
		break;
		
		case PLAYER.TAILS:
			mask_index = animation != ANIM.SPIN ? spr_tails_idle : spr_tails_spin;
		break;
		
		case PLAYER.KNUCKLES:
			mask_index = animation != ANIM.SPIN ? spr_knuckles_idle : spr_knuckles_spin;
		break;
		
		case PLAYER.AMY:
			mask_index = animation != ANIM.SPIN ? spr_amy_idle : spr_amy_spin;
		break;
	}
	
	if action == ACTION.HAMMERSPIN
	{
		m_set_extra_hitbox(25, 25, 0, 0);
	}
	else if animation == ANIM.HAMMERDASH
	{
		switch image_index % 4
		{
			case 0:
				m_set_extra_hitbox(16, 16, 6 * facing, 0);
			break;
			
			case 1:
				m_set_extra_hitbox(16, 16, -7 * facing, 0);
			break;
			
			case 2:
				m_set_extra_hitbox(14, 20, -4 * facing, -4);
			break;
			
			case 3:
				m_set_extra_hitbox(17, 21, 7 * facing, -5);
			break;
		}
	}
	else if shield_state == SHIELD_STATE.DOUBLE_SPIN
	{
		m_set_extra_hitbox(24, 24, 0, 0);
	}
	else
	{
		m_set_extra_hitbox(0, 0, 0, 0);
	}
}