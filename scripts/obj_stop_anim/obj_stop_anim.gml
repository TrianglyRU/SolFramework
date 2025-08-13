/// @self obj_game_object
/// @description Stops the animation playback by setting the frame to a specified index and clearing the duration. Additionally clears the play counter.
/// @param {Real} _image_index The frame index to set when stopping the animation (default is image_index).
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