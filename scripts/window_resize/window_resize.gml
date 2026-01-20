/// @self
/// @description Resizes the game window to match the current internal resolution and scale factor.
function window_resize()
{
	obj_game.alarm[1] = 10;
	window_set_size(surface_get_width(application_surface) * global.window_scale, surface_get_height(application_surface) * global.window_scale);
}