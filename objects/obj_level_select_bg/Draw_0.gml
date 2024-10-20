// Override draw
var _width = camera_get_width(0);
var _height = camera_get_height(0);

for (var _i = 0; _i < _width; _i += sprite_width)
{
	for (var _j = 0; _j < _height; _j += sprite_height)
	{
		draw_sprite(sprite_index, image_index, _i, _j);
	}
}