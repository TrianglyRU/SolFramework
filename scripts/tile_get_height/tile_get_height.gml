/// @self
/// @feather ignore GM1045
/// @description Retrieves the height of a specific tile in the room at a given x-coordinate within itself. Returns 0 if the tile index is invalid.
/// @param {Real} _tiledata The tile data.
/// @param {Real} _x The x-coordinate within the tile.
/// @returns {Real}
function tile_get_height(_tiledata, _x)
{
	var _index = tile_get_index(_tiledata) % TILE_COUNT;
	
	if (_index <= 0)
	{
		return 0;
	}
	
	var _height_index;
	
	if (tile_get_mirror(_tiledata))
	{
		_height_index = TILE_SIZE - 1 - _x % TILE_SIZE;
	}
	else
	{
		_height_index = _x % TILE_SIZE;
	}
	
	return obj_framework.tile_heights[_index][_height_index];
}