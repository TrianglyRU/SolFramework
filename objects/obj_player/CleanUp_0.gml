if (!variable_instance_exists(id, "player_index"))
{
	return;
}

ds_list_destroy(ds_record_data);

with (obj_player)
{
	if (player_index > other.player_index)
	{
		player_index--;
	}
}

ds_record_data = -1;