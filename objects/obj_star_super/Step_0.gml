if (!instance_exists(vd_target_player) || vd_target_player.super_timer <= 0)
{
	if (image_index == SUPERSTAR_LAST_FRAME)
	{
		instance_destroy();
	}
	
	return;
}

if (vd_target_player.action != ACTION.DASH && abs(vd_target_player.spd_ground) >= vd_target_player.acc_top)
{
	obj_set_anim(sprite_index, 2, 0, 0);
	
	if (anim_play_count < 1 || anim_frame_changed && image_index == 0)
	{
		x = vd_target_player.x;
		y = vd_target_player.y;
	}
}
else if (image_index == SUPERSTAR_LAST_FRAME && anim_duration > 0)
{
	obj_stop_anim();
}