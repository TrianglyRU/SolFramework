/// @self g_object
/// @description Configures the solid collision area.
/// @param {Real} _radius_x The horizontal radius of the solid collision area.
/// @param {Real} _radius_y The vertical radius of the solid collision area.
/// @param {Real} [_offset_x] The horizontal offset of the area from the object's centre (default is 0).
/// @param {Real} [_offset_y] The vertical offset of the area from the object's centre (default is 0).
function obj_set_solid(_radius_x, _radius_y, _offset_x = 0, _offset_y = 0)
{
	solid_radius_x = _radius_x;
	solid_radius_y = _radius_y;
	solid_offset_x = _offset_x;
	solid_offset_y = _offset_y;
	solid_height_map = [];
}
