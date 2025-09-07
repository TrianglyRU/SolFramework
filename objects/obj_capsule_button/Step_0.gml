offset_y = 0;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	solid_object(_player, SOLID_TYPE.FULL);
	
	if offset_y == 0 && solid_touch[_p] == SOLID_TOUCH.TOP
	{
		offset_y = 8;
	}
}

y = ystart + offset_y;