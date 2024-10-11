/// @self
/// @description Clears all active distortion effects from the foreground.
function dist_clear_fg()
{
	with (obj_framework)
	{
		for (var _i = array_length(distortion_fg_layers) - 1; _i >= 0; _i--)
		{
			var _layer = distortion_fg_layers[_i];
		
			if (layer_get_fx(_layer) != -1)
			{
				layer_clear_fx(_layer);
			}
		}
		
		distortion_effects[0] = -1;
		distortion_has_data[0] = [false, false];
	}
}