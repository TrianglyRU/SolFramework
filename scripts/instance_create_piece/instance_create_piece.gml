function instance_create_piece(_x, _y, _spriteid, _image_index, _startx, _starty, _width, _height, _vel_x, _vel_y, _delay, _flip_x, _flip_y, _flicker)
{
	with instance_create(_x, _y, obj_piece)
	{
		sprite_index = _spriteid;
		image_index = _image_index;
		draw_start_x = _startx;
		draw_start_y = _starty;
		draw_width = _width;
		draw_height = _height;
		vel_x = _vel_x;
		vel_y = _vel_y;
		wait_time = _delay;
		flip_x = _flip_x;
		flip_y = _flip_y;
		flicker = _flicker;
	}
}