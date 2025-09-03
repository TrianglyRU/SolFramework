/// @self obj_player
function scr_player_update_collision()
{
	if animation != ANIM.DUCK || global.player_physics >= PHYSICS.S3
	{
		m_set_hitbox(8, solid_radius_y - 3, 0, 0);
	}
	else if player_type != PLAYER.TAILS && player_type != PLAYER.AMY
	{
		m_set_hitbox(8, 10, 0, 6);
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