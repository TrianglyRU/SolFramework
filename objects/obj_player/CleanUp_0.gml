obj_game.player_count--;

if (variable_instance_exists(id, "player_index"))
{
	ds_list_destroy(ds_record_data);
	
	var _this_index = player_index;
	with (obj_player)
	{
		if (player_index > _this_index)
		{
			player_index--;
		}
	}
	
	ds_record_data = -1;
}