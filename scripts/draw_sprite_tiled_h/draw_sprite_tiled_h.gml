/// @self
/// @description This function will take a sprite and then repeatedly tile it across the given area horizontally.
/// @param {Asset.GMSprite} _sprite The index of the sprite to draw.
/// @param {Real} _subimg The frame of the sprite to draw.
/// @param {Real} _x The x coordinate of where to draw the sprite.
/// @param {Real} _y The y coordinate of where to draw the sprite.
/// @param {Real} _limit_left The left limit of the area in which the sprite should be tiled. 
/// @param {Real} _limit_right The right limit of the area in which the sprite should be tiled.
function draw_sprite_tiled_h(_sprite, _subimg, _x, _y, _limit_left, _limit_right)
{
	draw_sprite_tiled_h_ext(_sprite, _subimg, _x, _y, 1.0, 1.0, c_white, 1.0, _limit_left, _limit_right);
}