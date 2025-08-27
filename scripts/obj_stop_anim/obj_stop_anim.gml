/// @self g_object
/// @description Resets and stops the animation playback.
/// @param {Real} _image_index The frame index to set when stopping the animation (default is current image_index).
function obj_stop_anim(_image_index = image_index)
{
	if (image_index != _image_index)
	{
		anim_frame_changed = true;
	}
	
	anim_timer = 0;
	anim_play_count = 0;
	anim_duration = -1;
	image_index = _image_index;
}