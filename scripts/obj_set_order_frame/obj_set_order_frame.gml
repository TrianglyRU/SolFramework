/// @self obj_instance
/// @description Sets the current frame and updates the animation order index to the first matching frame.
/// @param {real} _image_index The index of the image frame to set.
function obj_set_order_frame(_image_index)
{
	for (var _i = 0; _i < anim_order_length; _i++)
	{
		if (anim_order[_i] == _image_index)
		{
			image_index = _image_index;
			anim_order_index = _i;
			anim_timer = anim_duration;
			
			break;
		}
	}
}