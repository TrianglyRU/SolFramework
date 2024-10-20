/// @self
/// @description Applies distortion to foreground layers. Distortion is not applied to object instance layers.
/// @param {Array<Real>|Undefined} _data1 The first set of distortion data.
/// @param {Array<Real>|Undefined} _data2 The second set of distortion data.
/// @param {Real} _speed The speed of distortion.
/// @param {Real} _range_start The upper boundary of the distortion area, in room space.
/// @param {Real} _range_end The lower boundary of the distortion area, in room space.
/// @param {Array<String>} _layers An array of layer names to which the distortion will be applied.
function dist_set_fg(_data1, _data2, _speed, _range_start, _range_end, _layers)
{
	var _effect = fx_create("_filter_sol_distortion");
	
	if (_effect == -1)
	{
		return;
	}
	
	with (obj_framework)
	{
		distortion_fg_layers = _layers;
		distortion_effects[0] = _effect;
		distortion_speeds[0] = _speed;
		distortion_ranges[0] = [_range_start, _range_end];
		
		if (is_not_null_array(_data1))
		{
			fx_set_parameter(_effect, "g_DataA", _data1);
			fx_set_parameter(_effect, "g_DataSizeA", array_length(_data1));
			
			distortion_has_data[0][0] = true;
		}

		if (is_not_null_array(_data2))
		{
			fx_set_parameter(_effect, "g_DataB", _data2);
			fx_set_parameter(_effect, "g_DataSizeB", array_length(_data2));
			
			distortion_has_data[0][1] = true;
		}
	}
	
	if (!is_not_null_array(_layers))
	{
		return;
	}
	
	fx_set_single_layer(_effect, true);
	
	for (var _i = array_length(_layers) - 1; _i >= 0; _i--)
	{
		layer_set_fx(_layers[_i], _effect);
	}
}