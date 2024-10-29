/// @self
/// @feather ignore GM1045
/// @description Retrieves the width of a specific tile in the room at a given y-coordinate within itself. Returns 0 if the tile index is invalid.
/// @param {Real} _tiledata The tile data.
/// @param {Real} _y The y-coordinate within the tile.
/// @returns {Real}
function tile_get_width(_tiledata, _y)
{
	var _index = tile_get_index(_tiledata) % TILE_COUNT;
	
	if (_index <= 0)
	{
		return 0;
	}
	
	var _width_index;
	
	if (tile_get_flip(_tiledata))
	{
		_width_index = TILE_SIZE - 1 - _y % TILE_SIZE;
	}
	else
	{
		_width_index = _y % TILE_SIZE;
	}
	
	return obj_framework.tile_widths[_index][_width_index];
}
