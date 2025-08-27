// Override draw
if (sprite_index >= 0)
{
	var _scale_x = flip_x ? -1 : 1;
	var _scale_y = flip_y ? -1 : 1;
	var _x = x - width * 0.5 * _scale_x;
	var _y = y - height * 0.5 * _scale_y;
	
	draw_sprite_part_ext(sprite_index, image_index, draw_start_x, draw_start_y, draw_width, draw_height, floor(_x), floor(_y), _scale_x, _scale_y, c_white, 1);
}