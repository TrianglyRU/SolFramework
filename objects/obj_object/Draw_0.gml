if sprite_index != -1
{
	draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, draw_get_colour(), image_alpha);
	
	/*
	if object_index != obj_player
	{
		draw_set_alpha(0.75);
		draw_rect_floored(bbox_left, bbox_top, bbox_right, bbox_bottom, false, c_purple);
		draw_set_alpha(1.0);
	}
	*/
}