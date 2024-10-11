offset_y = 0;
	
for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	obj_act_solid(_player, SOLIDOBJECT.FULL);
	
	if (offset_y == 0 && obj_check_solid(_player, SOLIDCOLLISION.TOP))
	{
		offset_y = 8;
	}
}

y = ystart + offset_y;