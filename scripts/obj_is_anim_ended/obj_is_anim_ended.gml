/// @self obj_game_object
/// @description Checks if the animation sequence has finished playing.
/// @returns {Bool}
function obj_is_anim_ended()
{
	return anim_timer == -1;
}