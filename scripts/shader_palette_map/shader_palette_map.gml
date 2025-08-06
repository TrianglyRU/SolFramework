/// @self
/// @description Applies a colour swap to subsequent draw calls using the properties of the given camera and the palette map data defined in obj_game.
/// @param {Real} _camera_index The index of the camera whose parameters to use.
function shader_palette_map(_camera_index)
{
	gml_pragma("forceinline");
	
	var _data = obj_game.palette_data;
	var _screen_space_bound = obj_game.palette_bound - camera_get_y(_camera_index);
	var _camera_height = camera_get_height(_camera_index);
	var _scale_y = surface_get_height(view_surface_id[_camera_index]) / _camera_height;
	
	var _u_bound = shader_get_uniform(sh_palette_map, "u_bound");
	var _u_indicies = shader_get_uniform(sh_palette_map, "u_indices");
	
	shader_set(sh_palette_map);
	shader_set_uniform_f(_u_bound, _screen_space_bound * _scale_y);
	shader_set_uniform_f_array(_u_indicies, obj_game.palette_indices);
	
	// Palette A
	if (_screen_space_bound >= 0 && _data[0] != undefined)
	{
		var _texture = _data[0][0];
		var _texel_x = _data[0][1];
		var _texel_y = _data[0][2];
		var _uv_x = _data[0][3];
		var _uv_y = _data[0][4];
		var _uv_z = _data[0][5];
		
		var _u_uv = shader_get_uniform(sh_palette_map, "u_uv_a");
		var _u_texel = shader_get_uniform(sh_palette_map, "u_texel_a");
		var _u_texture = shader_get_sampler_index(sh_palette_map, "u_texture_a");
		
		shader_set_uniform_f(_u_uv, _uv_x, _uv_y, _uv_z);
		shader_set_uniform_f(_u_texel, _texel_x, _texel_y);
		texture_set_stage(_u_texture, _texture);
	}
	
	// Palette B
	if (_screen_space_bound < _camera_height && _data[1] != undefined)
	{
		var _texture = _data[1][0];
		var _texel_x = _data[1][1];
		var _texel_y = _data[1][2];
		var _uv_x = _data[1][3];
		var _uv_y = _data[1][4];
		var _uv_z = _data[1][5];
		
		var _u_uv = shader_get_uniform(sh_palette_map, "u_uv_b");
		var _u_texel = shader_get_uniform(sh_palette_map, "u_texel_b");
		var _u_texture = shader_get_sampler_index(sh_palette_map, "u_texture_b");
		
		shader_set_uniform_f(_u_uv, _uv_x, _uv_y, _uv_z);
		shader_set_uniform_f(_u_texel, _texel_x, _texel_y);
		texture_set_stage(_u_texture, _texture);
	}
}