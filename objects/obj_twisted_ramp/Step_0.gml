for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if (!_player.is_grounded || _player.vel_x < 4 || _player.state >= PLAYERSTATE.LOCKED)
	{
	    continue;
	}
	
	var _relative_x = floor(_player.x) + 16 - x;
	var _relative_y = floor(_player.y) - y;
	
	if (_relative_x >= 0 && _relative_x < 32 && _relative_y >= -20 && _relative_y <= 32)
	{
		_player.reset_substate();
		_player.vel_y = -7;
		_player.vel_x += 4;
		_player.animation = ANIM.FLIP;
	}
}