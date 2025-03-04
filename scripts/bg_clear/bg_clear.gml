/// @self
/// @description Clears all background layers and effects.
function bg_clear()
{
	with (obj_framework)
	{
		bg_perspective_data[BG_PERSPECTIVE_LAYER_INDEX] = -1;
		bg_parallax_data = [];
		bg_layer_count = 0;
		bg_scroll_offset = 0;
		bg_min_factor_y = 0;
	}
	
	dist_clear_bg();
}