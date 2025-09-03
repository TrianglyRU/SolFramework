function instance_create_piece(_x, _y, _spriteid, _image_index, _startx, _starty, _width, _height, _vel_x, _vel_y, _delay, _flip_x, _flip_y, _flicker)
{
	var _piece = instance_create(_x, _y, obj_piece);
	
	_piece.sprite_index = _spriteid;
	_piece.image_index = _image_index;
	_piece.draw_start_x = _startx;
	_piece.draw_start_y = _starty;
	_piece.draw_width = _width;
	_piece.draw_height = _height;
	_piece.vel_x = _vel_x;
	_piece.vel_y = _vel_y;
	_piece.wait_time = _delay;
	_piece.flip_x = _flip_x;
	_piece.flip_y = _flip_y;
	_piece.flicker = _flicker;
}