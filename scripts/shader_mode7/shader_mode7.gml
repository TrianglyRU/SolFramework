/// @self
/// @description Applies a Mode 7 effect to subsequent draw calls.
/// @param {Real} _angle The horizontal viewing angle (turning the camera left or right).
/// @param {Real} _pitch The vertical pitch angle (tilting the camera up or down).
/// @param {Real} _fov_x The horizontal field of view.
/// @param {Real} _fov_y The vertical field of view.
/// @param {Real} _scroll_x The horizontal scroll offset within the texture.
/// @param {Real} _scroll_y The vertical scroll offset within the texture.
function shader_mode7(_angle, _pitch, _fov_x, _fov_y, _scroll_x, _scroll_y)
{
	gml_pragma("forceinline");
	
	var _u_angle = shader_get_uniform(sh_mode7, "u_angle");
	var _u_pitch = shader_get_uniform(sh_mode7, "u_pitch");
	var _u_fov = shader_get_uniform(sh_mode7, "u_fov");
	var _u_scroll = shader_get_uniform(sh_mode7, "u_scroll");

	shader_set(sh_mode7);
	shader_set_uniform_f(_u_angle, _angle);
	shader_set_uniform_f(_u_pitch, _pitch);
	shader_set_uniform_f(_u_fov, _fov_x, _fov_y);
	shader_set_uniform_f(_u_scroll, _scroll_x, _scroll_y);
}