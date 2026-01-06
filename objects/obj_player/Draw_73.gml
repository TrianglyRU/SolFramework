if global.dev_mode && keyboard_check(vk_shift)
{
	draw_rect_floored(floor(x) - radius_wall, floor(y) - radius_y, floor(x) + radius_wall - 1, floor(y) + radius_y - 1, false, c_yellow);
}

// Inherit the parent event
event_inherited();