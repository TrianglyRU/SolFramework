/// @self obj_player
function scr_player_jump_start()
{
	if forced_roll || action == ACTION.SPINDASH || action == ACTION.DASH
	{
		return;
	}

	if !input_press_action_any()
	{
		return;
	}
	
	var _angle_quad = math_get_quadrant(angle);
	var _max_dist = 6;
	var _ceil_dist = _max_dist;
	var _x, _y;
	
	switch _angle_quad
	{
		case QUADRANT.DOWN:	
			_ceil_dist = collision_tile_2v(x - solid_radius_x, y - solid_radius_y, x + solid_radius_x - 1, y - solid_radius_y, -1, secondary_layer, _angle_quad)[0];	
		break;

		case QUADRANT.RIGHT:
			_ceil_dist = collision_tile_2h(x - solid_radius_y, y - solid_radius_x, x - solid_radius_y, y + solid_radius_x - 1, -1, secondary_layer, _angle_quad)[0];
		break;

		case QUADRANT.LEFT:
			_ceil_dist = collision_tile_2h(x + solid_radius_y - 1, y - solid_radius_x, x + solid_radius_y - 1, y + solid_radius_x - 1, 1, secondary_layer, _angle_quad)[0];
		break;
	}

	if _ceil_dist < _max_dist
	{
		return;
	}
	
	if animation != ANIM.SPIN
	{
		y += solid_radius_y - radius_y_spin;
		solid_radius_x = radius_x_spin;
		solid_radius_y = radius_y_spin;
	}
	else if global.roll_lock && global.player_physics != PHYSICS.CD
	{
		air_lock_flag = true;
	}
	
	vel_x += jump_vel * dsin(angle);
	vel_y += jump_vel * dcos(angle);
	is_jumping = true;
	is_grounded = false;
	on_object = noone;
	set_push_anim_by = noone;
	stick_to_convex = false;
	animation = ANIM.SPIN;
	
	// Fix one-frame lag
	y -= vel_y; scr_player_position();
	
	audio_play_sfx(snd_jump);
	return true;
}
