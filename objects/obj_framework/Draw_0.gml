#region BACKGROUND

var _gfx_enabled = global.gfx_enabled;
var _view_x = camera_get_x(view_current);
var _view_y = camera_get_y(view_current);
var _half_height = camera_get_height(view_current) / 2;
var _perspective_factor_y = (bg_perspective_data[2] - _half_height) / (bg_perspective_data[1] - _half_height);

if (bg_layer_count > 0)
{
    if (_gfx_enabled)
	{
        shader_set_uniform_i(global.sh_bg_active, true);
	}

    for (var _i = 0; _i < bg_layer_count; _i++)
    {
        var _pd = bg_parallax_data[_i];
		
        if (bg_perspective_data[3] != -1)
		{
            _pd.factor_y = _perspective_factor_y;
		}
		
		var _draw_x = _view_x - CAMERA_HORIZONTAL_BUFFER;
        var _draw_y = floor(_view_y * (1 - _pd.factor_y)) + _pd.offset_y;
		var _scaling = 1.0;
        var _frame = 0;
		
        if (_pd.anim_duration > 0)
		{
            _frame = floor(frame_counter / _pd.anim_duration) % sprite_get_number(_pd.sprite);
		}
		
        if (_i == bg_perspective_data[3])
		{
            _scaling = clamp((bg_perspective_data[0] - _draw_y) / _pd.height_y, -1, 1);
		}
		
        if (_gfx_enabled)
        {
            if (_pd.field_line_height != 0)
            {
                shader_set_uniform_f(global.sh_bg_incline_step, _pd.field_line_step);
                shader_set_uniform_f(global.sh_bg_incline_height, _pd.field_line_height);
                shader_set_uniform_f(global.sh_bg_scaling, _scaling);
            }
			
            shader_set_uniform_f(global.sh_bg_offset, (_view_x + bg_scroll_offset) * _pd.factor_x - _pd.scroll_x, -_pd.scroll_y, CAMERA_HORIZONTAL_BUFFER, 0);
            shader_set_uniform_f(global.sh_bg_pos, _draw_x, _draw_y);
            shader_set_uniform_f(global.sh_bg_size, _pd.tex_width, _pd.height_y);
            shader_set_uniform_f(global.sh_bg_map_size, _pd.map_size_x, _pd.map_size_y);
        }
		
        draw_sprite_part_ext(_pd.sprite, _frame, 0, _pd.node_y, _pd.tex_width, _pd.height_y, _draw_x, _draw_y, 1.0, _scaling, c_white, 1.0);
		
        if (_gfx_enabled && _pd.field_line_height != 0)
        {
            shader_set_uniform_f(global.sh_bg_incline_height, 0);
            shader_set_uniform_f(global.sh_bg_scaling, 0);
        }
    }
	
	if (_gfx_enabled)
	{
        shader_set_uniform_i(global.sh_bg_active, false);
	}
}

#endregion