/// @self
/// @feather ignore GM1041
/// @description Identifies the nearest tile along a horizontal axis between two given points and returns an array containing two values: the distance to the found tile's edge and its angle.
/// @param {Real} _x1 The x-coordinate of the first point.
/// @param {Real} _y1 The y-coordinate of the first point.
/// @param {Real} _x2 The x-coordinate of the second point.
/// @param {Real} _y2 The y-coordinate of the second point.
/// @param {Enum.DIRECTION} _dir The direction in which to perform the search.
/// @param {Enum.TILELAYER} _layer The index of the tile layer to search within.
/// @param {Enum.TILEBEHAVIOUR} [_behaviour] The behaviour type of the tile (default is TILEBEHAVIOUR.DEFAULT).
/// @returns {Array<Real>}
function tile_find_2h(_x1, _y1, _x2, _y2, _dir, _layer, _behaviour = TILEBEHAVIOUR.DEFAULT)
{
    var _tile_data1 = tile_find_h(_x1, _y1, _dir, _layer, _behaviour);
    var _tile_data2 = tile_find_h(_x2, _y2, _dir, _layer, _behaviour);
    var _floor_dist1 = _tile_data1[0];
    var _floor_dist2 = _tile_data2[0];
	
    if (_floor_dist1 <= _floor_dist2)
    {
        return [_floor_dist1, _tile_data1[1]];
    }
	
    return [_floor_dist2, _tile_data2[1]];
}