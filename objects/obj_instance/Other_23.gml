anim_frame_change_flag = false;

if (anim_timer <= 0)
{
	exit;
}

if (--anim_timer > 0)
{
	exit;
}

var _last_frame = anim_order_length == 0 ? image_number - 1 : anim_order_length - 1;
var _end_reached = anim_order_length == 0 ? image_index == _last_frame : anim_order_index == _last_frame;

if (_end_reached)
{
    if (is_method(anim_end_routine))
    {
        anim_timer = -4;
        anim_end_routine();
		
        exit;
    }
	
    if (anim_end_routine == _last_frame)
    {
        anim_timer = -4;
        exit;
    }

    if (anim_order_length == 0)
    {
        image_index = anim_end_routine;
    }
    else
    {
        anim_order_index = anim_end_routine;
        image_index = anim_order[anim_order_index];
    }
	
	anim_loop_count++;
}
else
{
    if (anim_order_length == 0)
    {
        image_index++;
    }
    else
    {
        anim_order_index++;
        image_index = anim_order[anim_order_index];
    }
}

anim_timer = anim_duration;
anim_frame_change_flag = true;