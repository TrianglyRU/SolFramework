if global.debug_collision
{
	var _x = floor(x);
	var _y = floor(y);
	var _mask_index = mask_index;
	
	// Solidbox
	draw_rect_floored(floor(bbox_left), floor(bbox_top), floor(bbox_right) - 1, floor(bbox_bottom) - 1, true, c_fuchsia);
	
	// Hitbox
	draw_rect_floored(_x - radius_wall, _y - radius_y, _x + radius_wall - 1, _y + radius_y - 1, true, c_yellow);
	
	// Extra hitbox
	if is_extra_hitbox_active()
	{
		mask_index = extra_mask;
		draw_rect_floored(floor(bbox_left), floor(bbox_top), floor(bbox_right) - 1, floor(bbox_bottom) - 1, true, c_aqua);
		mask_index = _mask_index;
	}
	
	// Position
	draw_point_colour(_x, _y, c_aqua);
}