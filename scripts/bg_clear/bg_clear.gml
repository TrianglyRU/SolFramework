/// @self
/// @description Clears all background layers and effects.
function bg_clear()
{
	with (obj_framework)
	{
		bg_layer_count = 0;
		bg_scroll_offset = 0;
		bg_min_factor_y = 0;
		bg_perspective_data[3] = -1;
		bg_parallax_data = [];
	}
	
	dist_clear_bg();
}