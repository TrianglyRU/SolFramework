/// @self
/// @description						This function allows to alter angles of calculated tiles. Please note that this function will only have an effect while the collision hasn't been loaded for the use yet.
/// @param {Asset.GMSprite} _sprite_id	The sprite of the tilemap.
/// @param {Array<Array<Real>>} _pairs	An array of pairs in the form of [tile index, angle (in degrees)].
function tile_alter_angle(_sprite_id, _pairs)
{
	for (var _i = array_length(_pairs) - 1; _i >= 0; _i--)
	{
		var _pair = _pairs[_i];
		global.tile_stored_angle_data[? _sprite_id][_pair[0]] = _pair[1];
	}
}