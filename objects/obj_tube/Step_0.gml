for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if _p == 0
	{
		visible = _player.state == PLAYER_STATE.DEBUG_MODE;
	}
	
	var _list_pos = ds_list_find_index(ds_player_list, _player);
	
	if point_in_rectangle(floor(_player.x), floor(_player.y), bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1)
	{
		if _player.state >= PLAYER_STATE.DEFAULT_LOCKED
		{
			continue;
		}
		
		if iv_type == TUBE_TYPE.STOP
		{
			_player.forced_roll = false;
		}
		else if iv_type == TUBE_TYPE.KEEP_SPEED && _player.forced_roll
		{
			if _player.spd > 0 && _player.spd < 12
			{
				_player.spd = 12;
			}
			else if _player.spd < 0 && _player.spd > -12
			{
				_player.spd = -12;
			}
		}
		else if _list_pos == -1
		{
			if iv_type == TUBE_TYPE.START_X && _player.vel_x > 0 || iv_type == TUBE_TYPE.START_Y && _player.vel_y > 0
			{
				if iv_type == TUBE_TYPE.START_X
				{
					_player.spd = 12;
				}
				
				_player.action = ACTION.NONE;
				_player.forced_roll = true;
				_player.reset_gravity();
			}
			
			ds_list_add(ds_player_list, _player);
		}
	}
	else if _list_pos != -1
	{
		ds_list_delete(ds_player_list, _list_pos);
	}
}