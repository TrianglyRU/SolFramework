/// @function scr_player_update_collision()
/// @self obj_player
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
		obj_set_hitbox_ext(25, 25);
	}
	else if (animation == ANIM.HAMMERDASH)
	{
		switch (image_index % 4)
		{
			case 0:
				obj_set_hitbox_ext(16, 16, 6 * facing, 0);
			break;
			case 1:
				obj_set_hitbox_ext(16, 16, -7 * facing, 0);
			break;
			case 2:
				obj_set_hitbox_ext(14, 20, -4 * facing, -4);
			break;
			case 3:
				obj_set_hitbox_ext(17, 21, 7 * facing, -5);
			break;
		}
	}
	else if (shield_state == SHIELDSTATE.DOUBLESPIN)
	{
		obj_set_hitbox_ext(24, 24);
	}
	else
	{
		obj_set_hitbox_ext(0, 0);
	}
	
	if (global.dev_mode && global.debug_collision == 2)
	{
		var _ds_list = obj_framework.debug_interact;
		
		var _x = floor(x);
		var _y = floor(y);
		var _l = _x - interact_radius_x + interact_offset_x;
		var _r = _x + interact_radius_x + interact_offset_x;
		var _t = _y - interact_radius_y + interact_offset_y;
		var _b = _y + interact_radius_y + interact_offset_y;
		var _l_ext = _x - interact_radius_x_ext + interact_offset_x_ext;
		var _r_ext = _x + interact_radius_x_ext + interact_offset_x_ext;
		var _t_ext = _y - interact_radius_y_ext + interact_offset_y_ext;
		var _b_ext = _y + interact_radius_y_ext + interact_offset_y_ext;
		
		ds_list_add(_ds_list, _l_ext, _t_ext, _r_ext, _b_ext, $0000DC, id, _l, _t, _r, _b, $FF00DC, id);
	}
}