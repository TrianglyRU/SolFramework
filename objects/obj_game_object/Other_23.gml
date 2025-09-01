/// @description Animator
/// Called in obj_game -> Begin Step -> INSTANCE ANIMATOR. Override if not required!

if image_speed == 0 && image_duration > 0 && image_timer > 0
{
	if --image_timer == 0
	{
		if image_index == image_number - 1
		{
			sprite_play_count++;
			
			if image_loopback == image_index
			{
				image_timer = -1;
			}
			else
			{
				image_index = image_loopback;
				image_timer = image_duration;
			}
		}
		else
		{
			image_index++;
			image_timer = image_duration;
		}
	}
}