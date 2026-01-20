/// @self
/// @description						Applies a line shift pseudo-3D effect to a subsequent sprite draw based on camera position. The shader requires the sprite to have "Separate Texture Page" enabled, and the sprite's width must be a power of two.
/// @param {Real} _camera_x				The horizontal position of the camera.
/// @param {Real} _offset_x				The additional horizontal distance applied to the effect. Requires the depth to be positive.
/// @param {Real} _sprite_x				The x-position of the sprite in the room.
/// @param {Real} _sprite_y				The y-position of the sprite in the room.
/// @param {Real} _sprite_w				The width of the sprite. Must be a power of two.
/// @param {Real} _sprite_h				The height of the sprite.
/// @param {Real} _yscale				The vertical scaling of the sprite.
/// @param {Real} _depth				The amount of scroll difference between the farthest and nearest lines.
/// @param {Real} _line_h				The height of each scrolling line in pixels. Smaller values increase visual smoothness.
function shader_line_shift(_camera_x, _offset_x, _sprite_x, _sprite_y, _sprite_w, _sprite_h, _yscale, _depth, _line_h)
{
	var _u_pos = shader_get_uniform(sh_line_shift, "u_pos");
	var _u_size = shader_get_uniform(sh_line_shift, "u_size");
	var _u_camera_x = shader_get_uniform(sh_line_shift, "u_camera_x");
	var _u_offset_x = shader_get_uniform(sh_line_shift, "u_offset_x");
	var _u_line_h = shader_get_uniform(sh_line_shift, "u_line_h");
	var _u_lines_total = shader_get_uniform(sh_line_shift, "u_lines_total");
	var _u_yscale = shader_get_uniform(sh_line_shift, "u_yscale");
	var _u_increment = shader_get_uniform(sh_line_shift, "u_increment");
	
    var _lines_total = (_sprite_h / _line_h) - 1;
    var _increment = _depth / _lines_total;
	
	if _depth <= 0
	{
		_offset_x = 0;
	}
	
	// Feather ignore GM2003
	shader_set(sh_line_shift);
	shader_set_uniform_f(_u_pos, _sprite_x, _sprite_y);
	shader_set_uniform_f(_u_size, _sprite_w, _sprite_h);
	shader_set_uniform_f(_u_camera_x, _camera_x);
	shader_set_uniform_f(_u_offset_x, _offset_x);
	shader_set_uniform_f(_u_line_h, _line_h);
	shader_set_uniform_f(_u_lines_total, _lines_total);
	shader_set_uniform_f(_u_yscale, _yscale);
	shader_set_uniform_f(_u_increment, _increment);
}