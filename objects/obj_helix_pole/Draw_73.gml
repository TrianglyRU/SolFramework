if global.dev_mode && keyboard_check(vk_shift)
{
	draw_rect_floored(floor(bbox_left) + offset_x, floor(bbox_top), floor(bbox_right) + offset_x - 1, floor(bbox_bottom) - 1, true, c_fuchsia);
}