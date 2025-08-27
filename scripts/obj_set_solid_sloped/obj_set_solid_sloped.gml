/// @self g_object
/// @description Configures the solid collision area using a height map.
/// @param {Array<Real>} _height_map An array of numbers representing the height throughout the object.
/// @param {Real} [_offset_x] The horizontal offset of the area from the object's centre (default is 0).
/// @param {Real} [_offset_y] The vertical offset of the area from the object's centre (default is 0).
function obj_set_solid_sloped(_height_map, _offset_x = 0, _offset_y = 0)
{
	var _width = array_length(_height_map);
	solid_radius_x = floor(_width * 0.5);
	solid_radius_y = max(_height_map[0], _height_map[_width - 1]);
	solid_offset_x = _offset_x;
	solid_offset_y = _offset_y;
	solid_height_map = _height_map;
}