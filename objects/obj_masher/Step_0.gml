if (!obj_act_enemy())
{
	exit;
}

y += vel_y;
vel_y += 0.09375;

if (y >= ystart - 192)
{
	if (y >= ystart)
	{
		y = ystart;
		vel_y = MASHER_VEL_Y_DEFAULT;
	}
	
	if (vel_y < 0)
	{
		obj_set_anim(sprite_index, 8, 0, 0);
	}
	else
	{
		obj_stop_anim(0);
	}
}
else
{
	obj_set_anim(sprite_index, 4, 0, 0);
}