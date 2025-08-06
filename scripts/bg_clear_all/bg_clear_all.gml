/// @self
/// @description Removes all background objects and the temporary layers they occupy.
function bg_clear_all()
{
	with (obj_game_layer)
	{
		instance_destroy();
	}
	
	obj_game.bg_distance_x = 0;
	obj_game.bg_distance_y = 0;
	obj_game.bg_scroll_x = 0;
	obj_game.bg_scroll_y = 0;
}