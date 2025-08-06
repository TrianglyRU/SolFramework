/// @self
/// @description This function will take a sprite and then repeatedly tile it across the given area horizontally.
/// @param {Asset.GMSprite} _sprite The index of the sprite to draw.
/// @param {Real} _subimg The frame of the sprite to draw.
/// @param {Real} _x The x coordinate of where to draw the sprite.
/// @param {Real} _y The y coordinate of where to draw the sprite.
/// @param {Real} _xscale The horizontal scaling of the sprite.
/// @param {Real} _yscale The vertical scaling of the sprite.
/// @param {Real} _colour The colour with witch to blend the sprite.
/// @param {Real} _alpha The alpha of the sprite.
/// @param {Real} _limit_left The left limit of the area in which the sprite should be tiled. 
/// @param {Real} _limit_right The right limit of the area in which the sprite should be tiled.
function draw_sprite_tiled_h_ext(_sprite, _subimg, _x, _y, _xscale, _yscale, _colour, _alpha, _limit_left, _limit_right)
{
    var _width = sprite_get_width(_sprite) * _xscale;
	var _offset = sprite_get_xoffset(_sprite) * _xscale;
	
	draw_sprite_ext(_sprite, _subimg, _x, _y, _xscale, _yscale, 0.0, _colour, _alpha);
	
	var _left_x = _x - _width;
	while (_left_x + _width - _offset > _limit_left)
	{
		draw_sprite_ext(_sprite, _subimg, _left_x, _y, _xscale, _yscale, 0.0, _colour, _alpha);
		_left_x -= _width;
	}
	
	var _right_x = _x + _width;
	while (_right_x - _offset < _limit_right)
	{
		draw_sprite_ext(_sprite, _subimg, _right_x, _y, _xscale, _yscale, 0.0, _colour, _alpha);
		_right_x += _width;
	}
}