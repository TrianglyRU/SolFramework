/// @self obj_player
/// @function scr_player_update_collision()
function scr_player_update_collision()
{
	gml_pragma("forceinline");
	
	obj_set_solid(radius_x_normal + 1, radius_y);
	
	if (animation != ANIM.DUCK || global.player_physics >= PHYSICS.S3)
	{
		obj_set_hitbox(8, radius_y - 3);
	}
	else if (vd_player_type != PLAYER.TAILS && vd_player_type != PLAYER.AMY)
	{
		obj_set_hitbox(8, 10, 0, 6);
	}
	
	if (action == ACTION.HAMMERSPIN)
	{
		self.set_extra_hitbox(25, 25);
	}
	else if (animation == ANIM.HAMMERDASH)
	{
		switch (image_index % 4)
		{
			case 0:
				self.set_extra_hitbox(16, 16, 6 * facing, 0);
			break;
			
			case 1:
				self.set_extra_hitbox(16, 16, -7 * facing, 0);
			break;
			
			case 2:
				self.set_extra_hitbox(14, 20, -4 * facing, -4);
			break;
			
			case 3:
				self.set_extra_hitbox(17, 21, 7 * facing, -5);
			break;
		}
	}
	else if (shield_state == SHIELDSTATE.DOUBLESPIN)
	{
		self.set_extra_hitbox(24, 24);
	}
	else
	{
		self.set_extra_hitbox(0, 0);
	}
}