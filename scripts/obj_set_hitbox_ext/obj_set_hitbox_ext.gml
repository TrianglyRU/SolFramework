/// @self obj_instance
/// @description Configures the additional hitbox.
/// @param {Real} _radius_x The horizontal radius of the additional hitbox.
/// @param {Real} _radius_y The vertical radius of the additional hitbox.
/// @param {Real} [_offset_x] The horizontal offset of the hitbox from the object's centre (default is 0).
/// @param {Real} [_offset_y] The vertical offset of the hitbox from the object's centre (default is 0).
function obj_set_hitbox_ext(_radius_x, _radius_y, _offset_x = 0, _offset_y = 0)
{
	interact_radius_x_ext = _radius_x;
	interact_radius_y_ext = _radius_y;
	interact_offset_x_ext = _offset_x;
	interact_offset_y_ext = _offset_y;
}