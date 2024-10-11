/// @self obj_instance
/// @description Resets the animation to the first frame and restarts the animation timer. If a custom playback order is used, the first frame in the order will be set.
function obj_restart_anim()
{
	if (anim_order_length == 0)
	{
		image_index = 0;
	}
	else
	{
		anim_order_index = 0;
		image_index = anim_order[anim_order_index];
	}
	
	anim_timer = anim_duration;
}