visible = player_get(0).state == PLAYER_STATE.DEBUG_MODE;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	var _list_pos = ds_list_find_index(ds_player_list, _player);
	
	if point_in_rectangle(floor(_player.x), floor(_player.y), bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1) && _player.is_grounded
	{
		if _list_pos == -1
		{
			_player.forced_roll = true;
			_player.stick_to_convex = true;
			
			ds_list_add(ds_player_list, _player);
		}
		else
		{
			_player.spd = clamp(_player.spd, -15, 15);
		}
	}
	else if _list_pos != -1
	{
		_player.forced_roll = false;
		_player.stick_to_convex = false;
		
		ds_list_delete(ds_player_list, _list_pos);
	}
}