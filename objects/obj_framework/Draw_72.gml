#region EFFECTS

if (!global.gfx_enabled)
{
	exit;
}

var _view_y = camera_get_y(view_current);
var _view_height = camera_get_height(view_current);
var _y_multiplier = surface_get_height(view_surface_id[view_current]) / _view_height;
var _half_height = _view_height / 2;
var _perspective_factor_y = (bg_perspective_data[2] - _half_height) / (bg_perspective_data[1] - _half_height);

shader_set(sh_orbinaut);
	
// FADE
	
var _timer = fade_timer;

if (fade_type == FADETYPE.DULLORDER || fade_type == FADETYPE.DULLSYNC || fade_type == FADETYPE.FLASHORDER || fade_type == FADETYPE.FLASHSYNC)
{
	_timer = floor(_timer / 3);
}

shader_set_uniform_i(global.sh_fade_type, fade_type);
shader_set_uniform_f(global.sh_fade_timer, _timer);
shader_set_uniform_i(global.sh_fade_active, true);

// PALETTE

var _palette_bound_ss = palette_bound - _view_y;
var _colour_data1 = palette_data[0];
var _colour_data2 = palette_data[1];
var _colour_data1_local = palette_data[2];
var _colour_data2_local = palette_data[3];

if (_palette_bound_ss >= 0)
{
	if (is_not_null_array(_colour_data1))
	{
		texture_set_stage(global.sh_pal_tex_a_global, _colour_data1[0]);
	    shader_set_uniform_f(global.sh_pal_texel_size_a_global, _colour_data1[1], _colour_data1[2]);
	    shader_set_uniform_f(global.sh_pal_uv_a_global, _colour_data1[3], _colour_data1[4], _colour_data1[5]);
	}  
	
	if (is_not_null_array(_colour_data1_local))
	{
		texture_set_stage(global.sh_pal_tex_a_local, _colour_data1_local[0]);
	    shader_set_uniform_f(global.sh_pal_texel_size_a_local, _colour_data1_local[1], _colour_data1_local[2]);
	    shader_set_uniform_f(global.sh_pal_uv_a_local, _colour_data1_local[3], _colour_data1_local[4], _colour_data1_local[5]);
	}
}

if (_palette_bound_ss < _view_height)
{
	if (is_not_null_array(_colour_data2))
	{
		texture_set_stage(global.sh_pal_tex_b_global, _colour_data2[0]);
		shader_set_uniform_f(global.sh_pal_texel_size_b_global, _colour_data2[1], _colour_data2[2]);
		shader_set_uniform_f(global.sh_pal_uv_b_global, _colour_data2[3], _colour_data2[4], _colour_data2[5]);
	}
	
	if (is_not_null_array(_colour_data2_local))
	{
		texture_set_stage(global.sh_pal_tex_b_local, _colour_data2_local[0]);
		shader_set_uniform_f(global.sh_pal_texel_size_b_local, _colour_data2_local[1], _colour_data2_local[2]);
		shader_set_uniform_f(global.sh_pal_uv_b_local, _colour_data2_local[3], _colour_data2_local[4], _colour_data2_local[5]);
	}
}

shader_set_uniform_f_array(global.sh_pal_indices, palette_indices);
shader_set_uniform_f(global.sh_pal_bound, _palette_bound_ss * _y_multiplier);
shader_set_uniform_i(global.sh_pal_active, true);
	
// DISTORTION
	
var _distortion_bound_ss = distortion_bound - _view_y;
	
for (var _i = 0; _i < 2; _i++)
{
    var _effect = distortion_effects[_i];
	var _draw_y = _view_y;
		
    if (_effect == -1)
	{
        continue;
	}
	
	// Align with the background vertical parallax factor
	if (_i > 0)
	{
		_draw_y *= (bg_perspective_data[3] == -1 ? bg_min_factor_y : _perspective_factor_y);
	}
		
	var _has_data = distortion_has_data[_i];
	var _range = distortion_ranges[_i];
    var _u_bound = _range[0] >= 0 ? clamp(_range[0] - _draw_y, 0, _view_height) : 0;
    var _l_bound = _range[1] >= 0 ? clamp(_range[1] - _draw_y, 0, _view_height) : 0;
		
    if (_has_data[0] && !_has_data[1])
    {
        _u_bound = min(_u_bound, _distortion_bound_ss);
        _l_bound = min(_l_bound, _distortion_bound_ss);
    }
    else if (!_has_data[0] && _has_data[1])
    {
        _u_bound = max(_u_bound, _distortion_bound_ss);
        _l_bound = max(_l_bound, _distortion_bound_ss);
    }
    else
    {
        _u_bound = min(_u_bound, _distortion_bound_ss);
        _l_bound = max(_l_bound, _distortion_bound_ss);
    }
	
    fx_set_parameter(_effect, "g_Width", camera_get_width(view_current));
    fx_set_parameter(_effect, "g_BoundUpper", _u_bound * _y_multiplier);
    fx_set_parameter(_effect, "g_BoundMiddle", _distortion_bound_ss * _y_multiplier);
    fx_set_parameter(_effect, "g_BoundLower", _l_bound * _y_multiplier);
    fx_set_parameter(_effect, "g_Offset", floor(distortion_offsets[_i]) + _draw_y);
}

#endregion