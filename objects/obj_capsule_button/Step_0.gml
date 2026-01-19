y = ystart;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if _player != noone && _player.on_object == id
	{
		y = ystart + 8;
	}
	
	solid_object(_player, SOLID_TYPE.FULL);
}