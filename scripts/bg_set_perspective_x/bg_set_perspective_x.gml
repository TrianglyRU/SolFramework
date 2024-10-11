/// @self
/// @description Sets a horizontal perspective effect on the most recent background layer.
/// @param {Real} _target_x The target horizontal parallax factor for the bottom edge of the layer.
/// @param {Real} _line_height The height of one perspective line.
function bg_set_perspective_x(_target_x, _line_height)
{
	var _pd = {};
	
	with (obj_framework)
	{
		_pd = bg_parallax_data[bg_layer_count - 1];
	}
	
	_pd.field_line_step = (_target_x - _pd.factor_x) / (round(_pd.height_y / _line_height) - 1) / _target_x;
	_pd.field_line_height = _line_height;
	_pd.factor_x = _target_x;
}