/// @method calculate_data()
calculate_data = function(_sprite)
{
	sprite_index = _sprite;
	
	var _height_array = array_create(TILE_SIZE);
	var _width_array = array_create(TILE_SIZE);

	for (var _i = 0; _i < TILE_SIZE; _i++)
	{	
		for (var _j = 0; _j < TILE_SIZE; _j++)
		{
			if (collision_point(x + _i, y + _j, obj_game_tile, true, false))
			{
				_height_array[_i]++;
				_width_array[_j]++;
			}
		}
	}
	
	return [_height_array, _width_array];
}