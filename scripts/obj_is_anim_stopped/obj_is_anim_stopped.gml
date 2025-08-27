/// @self g_object
/// @description Checks if the animation playback has been manually stopped.
/// @returns {Bool}
function obj_is_anim_stopped()
{
	return anim_duration < 0;
}