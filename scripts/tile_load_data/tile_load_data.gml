/// @self
/// @description Loads pre-generated collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMSprite} _sprite_id The sprite used in the tilemap for which the collision data was generated.
/// @param {String} _layer_a The name of the primary layer in the room.
/// @param {String} _layer_b The name of the secondary layer in the room.
function tile_load_data(_sprite_id, _layer_a, _layer_b)
{
	with (obj_framework)
	{
		tile_heights = global.tile_height_data[? _sprite_id];
		tile_widths = global.tile_width_data[? _sprite_id];
		tile_angles = global.tile_angle_data[? _sprite_id];
		tile_layers = [layer_tilemap_get_id(_layer_a), layer_tilemap_get_id(_layer_b)];
	}
}