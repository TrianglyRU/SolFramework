/// @self
/// @description Applies a line scroll pseudo-3D effect to a subsequent sprite draw. This effect simulates depth by scrolling horizontal lines of the sprite at varying speeds, creating the illusion of perspective.  The shader requires the sprite to have "Separate Texture Page" enabled.
/// @param {Real} _camera_x The horizontal position of the camera.
/// @param {Real} _offset_x The additional horizontal distance applied to the effect. Requires the depth to be positive.
/// @param {Real} _sprite_x The x position of the sprite in the room.
/// @param {Real} _sprite_y The y position of the sprite in the room.
/// @param {Real} _sprite_h The height of the sprite.
/// @param {Real} _yscale The vertical scaling of the sprite.
/// @param {Pointer.Texture} _texture The texture page of the sprite.
/// @param {Real} _depth The amount of scroll difference between the farthest and nearest lines.
/// @param {Real} _line_h The height of each scrolling line in pixels. Smaller values increase visual smoothness.
function shader_line_scroll(_camera_x, _offset_x, _sprite_x, _sprite_y, _sprite_h, _yscale, _texture, _depth, _line_h)
{
	gml_pragma("forceinline");
	
	var _u_pos = shader_get_uniform(sh_line_scroll, "u_pos");
	var _u_texel_size = shader_get_uniform(sh_line_scroll, "u_texel_size");
	var _u_camera_x = shader_get_uniform(sh_line_scroll, "u_camera_x");
	var _u_offset_x = shader_get_uniform(sh_line_scroll, "u_offset_x");
	var _u_sprite_h = shader_get_uniform(sh_line_scroll, "u_sprite_h");
	var _u_line_h = shader_get_uniform(sh_line_scroll, "u_line_h");
	var _u_lines_total = shader_get_uniform(sh_line_scroll, "u_lines_total");
	var _u_yscale = shader_get_uniform(sh_line_scroll, "u_yscale");
	var _u_increment = shader_get_uniform(sh_line_scroll, "u_increment");
	
    var _lines_total = (_sprite_h / _line_h) - 1;
    var _increment = _depth / _lines_total;
    var _texel_w = 1 / texture_get_texel_width(_texture);
    var _texel_h = 1 / texture_get_texel_height(_texture);
	
	if (_depth <= 0)
	{
		_offset_x = 0;
	}
	
	shader_set(sh_line_scroll);
	shader_set_uniform_f(_u_pos, _sprite_x, _sprite_y);
	shader_set_uniform_f(_u_texel_size, _texel_w, _texel_h);
	shader_set_uniform_f(_u_camera_x, _camera_x);
	shader_set_uniform_f(_u_offset_x, _offset_x);
	shader_set_uniform_f(_u_sprite_h, _sprite_h);
	shader_set_uniform_f(_u_line_h, _line_h);
	shader_set_uniform_f(_u_lines_total, _lines_total);
	shader_set_uniform_f(_u_yscale, _yscale);
	shader_set_uniform_f(_u_increment, _increment);
}