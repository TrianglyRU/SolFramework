/// @description Apply Distortion

if room == rm_startup
{
	return;
}

var _camera_y = camera_get_y(view_current);
var _camera_width = camera_get_width(view_current);
var _camera_height = camera_get_height(view_current);
var _scale_y = surface_get_height(view_surface_id[view_current]) / _camera_height;
var _list_size = ds_list_size(distortion_data);
var _screen_space_bound = distortion_bound - _camera_y;

for (var _i = 0; _i < _list_size; _i++)
{
    var _data = distortion_data[| _i];
	var _draw_y = floor(_camera_y * _data.factor);
	var _offset = floor(_data.offset);
    var _has_a = _data.values_a != undefined;
    var _has_b = _data.values_b != undefined;
	var _effect = _data.effect;
	
    var _u_bound = clamp(_data.range_start - _draw_y, 0, _camera_height);
    var _l_bound = clamp(_data.range_end - _draw_y, 0, _camera_height);
	
    if _has_a && !_has_b
	{
        _u_bound = min(_u_bound, _screen_space_bound);
        _l_bound = min(_l_bound, _screen_space_bound);
    }
    else if !_has_a && _has_b
	{
        _u_bound = max(_u_bound, _screen_space_bound);
        _l_bound = max(_l_bound, _screen_space_bound);
    }
    else
	{
        _u_bound = min(_u_bound, _screen_space_bound);
        _l_bound = max(_l_bound, _screen_space_bound);
    }
	
    if _has_a
	{
        fx_set_parameter(_effect, "g_DataA", _data.values_a);
        fx_set_parameter(_effect, "g_DataSizeA", array_length(_data.values_a));
    }
	
    if _has_b
	{
        fx_set_parameter(_effect, "g_DataB", _data.values_b);
        fx_set_parameter(_effect, "g_DataSizeB", array_length(_data.values_b));
    }
	
    fx_set_parameter(_effect, "g_Width", _camera_width);
    fx_set_parameter(_effect, "g_Offset", _draw_y + _offset);
    fx_set_parameter(_effect, "g_BoundUpper", _u_bound * _scale_y);
    fx_set_parameter(_effect, "g_BoundMiddle", _screen_space_bound * _scale_y);
    fx_set_parameter(_effect, "g_BoundLower", _l_bound * _scale_y);
}