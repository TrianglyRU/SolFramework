/// Called in obj_game -> Begin Step -> INSTANCE ANIMATOR
/// @description Animation

anim_frame_change_flag = false;

if (anim_duration < 0 || anim_timer <= 0)
{
	return;
}

if (--anim_timer > 0)
{
	return;
}

if (image_index == image_number - 1)
{
	anim_play_count++;
	
    if (is_method(anim_end_routine))
    {
        anim_timer = -1;
        anim_end_routine();
        return;
    }
	
    if (anim_end_routine == image_number - 1)
    {
        anim_timer = -1;
        return;
    }
	
    image_index = anim_end_routine;
}
else
{
    image_index++;
}

anim_timer = anim_duration;
anim_frame_change_flag = true;