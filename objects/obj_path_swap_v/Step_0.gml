visible = global.debug_collision > 0;
	
for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if (_p == 0)
	{
		visible |= _player.state == PLAYERSTATE.DEBUG_MODE;
	}
	
	if (_player.state >= PLAYERSTATE.NO_CONTROL || !_player.is_grounded && vd_ground_only)
	{
		continue;
	}
		
	var _y_last = _player.yprevious;
	var _y = _player.y;
	var _x = _player.x;
	
	if (_x < bbox_left || _x >= bbox_right)
	{
		continue;
	}
	
	if (_y_last < y && _y >= y)
	{
		_player.tile_layer = vd_layer_below;
	}
	else if _y_last >= y && _y < y
	{
		_player.tile_layer = vd_layer_above;
	}
}