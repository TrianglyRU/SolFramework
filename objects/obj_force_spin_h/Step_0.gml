for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if _p == 0
	{
		visible = _player.state == PLAYER_STATE.DEBUG_MODE;
	}
	
	if _player.state >= PLAYER_STATE.DEFAULT_LOCKED
	{
		continue;
	}
	
	var _y_last = _player.yprevious;
	var _y = _player.y;
	var _x = _player.x;
	
	if _x < bbox_left || _x >= bbox_right
	{
		continue;
	}
	
	if (_y_last >= y || _y < y) && (_y_last < y || _y >= y)
	{
		continue;
	}
	
	switch iv_mode
	{
		case FORCE_SPIN.UNIVERSAL:
			_player.forced_roll = !_player.forced_roll;	
		break;
		
		case FORCE_SPIN.START_ONLY:
			_player.forced_roll = true;
		break;
		
		case FORCE_SPIN.END_ONLY:
			_player.forced_roll = false;
		break;
	}
	
	_player.action = ACTION.NONE;
	_player.reset_gravity();
}