/// @self
/// @description Applies distortion to the background layer.
/// @param {Array<Real>|Undefined} _data1 The first set of distortion data.
/// @param {Array<Real>|Undefined} _data2 The second set of distortion data.
/// @param {Real} _speed The speed of distortion.
/// @param {Real} _range_start The upper boundary of the distortion area, in background space.
/// @param {Real} _range_end The lower boundary of the distortion area, in background space.
function dist_set_bg(_data1, _data2, _speed, _range_start, _range_end)
{
	var _effect = fx_create("_filter_sol_distortion");
	
	if (_effect == -1)
	{
		exit;
	}
	
	with (obj_framework)
	{
		distortion_effects[1] = _effect;
		distortion_speeds[1] = _speed;
		distortion_ranges[1] = [_range_start, _range_end];
		
		if (is_not_null_array(_data1))
		{
			fx_set_parameter(_effect, "g_DataA", _data1);
			fx_set_parameter(_effect, "g_DataSizeA", array_length(_data1));
			
			distortion_has_data[1][0] = true;
		}

		if (is_not_null_array(_data2))
		{
			fx_set_parameter(_effect, "g_DataB", _data2);
			fx_set_parameter(_effect, "g_DataSizeB", array_length(_data2));
			
			distortion_has_data[1][1] = true;
		}
	}
	
	layer_set_fx(obj_framework.layer, _effect);
}