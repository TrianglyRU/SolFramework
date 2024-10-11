for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if (!_player.is_grounded)
	{
		continue;
	}
	
	var _player_x = floor(_player.x);
	var _player_y = floor(_player.y);
	
	if (_player_x >= bbox_left && _player_x < bbox_right && _player_y >= bbox_top && _player_y < bbox_bottom)
	{
		if (_player.angle == 90)
		{
			catched_players[_p] = true;
		}
	}
	else
	{
		catched_players[_p] = false;
	}
	
	if (catched_players[_p])
	{
		_player.x = _player.xprevious;
		_player.image_angle = 90;
	}
}