/// @self obj_instance
/// @description Stops the animation by setting the frame to a specified index and resetting the animation timer. It ignores any custom playback order by directly setting image_index.
/// @param {Real} _image_index The frame index to set when stopping the animation (default is image_index).
function obj_stop_anim(_image_index = image_index)
{
	if (image_index != _image_index)
	{
		anim_frame_change_flag = true;
	}
	
	anim_timer = 0;
	anim_duration = 0;
	image_index = _image_index;
}