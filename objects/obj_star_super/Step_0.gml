if (!instance_exists(vd_target_player) || vd_target_player.super_timer <= 0)
{
	if (image_index == SUPERSTAR_LAST_FRAME)
	{
		instance_destroy();
	}
	
	return;
}

var _do_update = !obj_is_anim_stopped();
if (vd_target_player.action != ACTION.DASH && abs(vd_target_player.spd_ground) >= vd_target_player.acc_top)
{
	if (!_do_update)
	{
		attach_to_player = true;
		obj_set_anim(sprite_index, 2, 0, 0);
	}
	
	if (attach_to_player || image_index == 0 && anim_frame_change_flag)
	{
		x = vd_target_player.x;
		y = vd_target_player.y;
		
		if (attach_to_player && image_index == SUPERSTAR_LAST_FRAME)
		{
			attach_to_player = false;
		}
	}
}
else if (_do_update && image_index == SUPERSTAR_LAST_FRAME)
{
	obj_stop_anim();
}