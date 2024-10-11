/// @self
/// @description Clears all active distortion effects from the background.
function dist_clear_bg()
{
	with (obj_framework)
	{
		if (layer_get_fx(layer) != -1)
		{
			layer_clear_fx(layer);
		}
	
		distortion_effects[1] = -1;
		distortion_has_data[1] = [false, false];
	}
}