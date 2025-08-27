/// @self g_object
/// @description Resets and restarts the animation playback from the first frame.
/// @param {Bool} _reset_play_count Whether to reset the play counter (default is true).
function obj_restart_anim(_reset_play_count = true)
{
	image_index = 0;
	anim_timer = anim_duration;
	
	if (_reset_play_count)
	{
		anim_play_count = 0;
	}
}