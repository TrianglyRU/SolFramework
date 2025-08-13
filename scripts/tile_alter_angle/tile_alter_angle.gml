/// @self
/// @description This function allows to alter an angle of a calculated tile. Please note that this function will only have an effect while the collision hasn't been loaded for the use yet.
/// @param {Asset.GMSprite} _sprite_id The sprite of the tilemap.
/// @param {Real} _index The tile index.
/// @param {Real} _angle A new angle to assign (in degrees).
function tile_alter_angle(_sprite_id, _index, _angle)
{
	global.tile_stored_angle_data[? _sprite_id][_index] = _angle;
}