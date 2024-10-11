/// @self
/// @description Retrieves the angle of a tile based on its index. Returns TILE_EMPTY_ANGLE if the tile of the given index is non-existent.
/// @param {Real} _tiledata The tile data.
/// @returns {Real|Constant}
function tile_get_angle(_tiledata)
{
	var _index = tile_get_index(_tiledata) % TILE_COUNT;
	
	if (_index <= 0)
	{
		return TILE_EMPTY_ANGLE;
	}
	
	return obj_framework.tile_angles[_index];
}