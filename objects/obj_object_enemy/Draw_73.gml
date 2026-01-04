if global.dev_mode && keyboard_check(vk_shift)
{
	draw_rect_floored(floor(bbox_left), floor(bbox_top), floor(bbox_right) - 1, floor(bbox_bottom) - 1, false, c_red);
}