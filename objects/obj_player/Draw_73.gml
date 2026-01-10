if global.dev_mode && keyboard_check(vk_shift)
{
	// Solidbox
	draw_rect_floored(floor(bbox_left), floor(bbox_top), floor(bbox_right) - 1, floor(bbox_bottom) - 1, true, c_fuchsia);
	
	// Hitbox
	draw_rect_floored(floor(x) - radius_wall, floor(y) - radius_y, floor(x) + radius_wall - 1, floor(y) + radius_y - 1, true, c_yellow);
	
	// Extra hitbox
	if is_extra_hitbox_active()
	{
		var _prev_mask = mask_index;
		mask_index = extra_mask;
		draw_rect_floored(floor(bbox_left), floor(bbox_top), floor(bbox_right) - 1, floor(bbox_bottom) - 1, true, c_aqua);
		mask_index = _prev_mask;
	}
}