/// @self obj_instance
/// @description Checks if the animation playback has been manually stopped.
/// @returns {Bool}
function obj_is_anim_stopped()
{
	return anim_timer == 0;
}