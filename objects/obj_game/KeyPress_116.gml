/// @description Toggle Profiler
if global.dev_mode
{
	global.debug_framework = !global.debug_framework;
	
	// TODO: enable in LTS'25
	// show_debug_overlay(!is_debug_overlay_open());
}