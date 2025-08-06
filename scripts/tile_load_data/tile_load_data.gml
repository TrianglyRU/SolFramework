/// @self
/// @description Loads pre-generated collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMSprite} _sprite_id The sprite used in the tilemap for which the collision data was generated.
/// @param {String} _layer_main The name of the main collision layer (TILELAYER.MAIN) in the room.
/// @param {String|Undefined} _layer_secondary_a The name of the first additional collision layer (TILELAYER.SECONDARY_A) in the room.
/// @param {String|Undefined} _layer_secondary_b The name of the second additional collision layer (TILELAYER.SECONDARY_B) in the room.
function tile_load_data(_sprite_id, _layer_main, _layer_secondary_a, _layer_secondary_b)
{
	obj_game.tile_layers = 
	[
		layer_tilemap_get_id(_layer_main),			// TILELAYER.MAIN (0)
		layer_tilemap_get_id(_layer_secondary_a),	// TILELAYER.SECONDARY_A (1)	
		layer_tilemap_get_id(_layer_secondary_b)	// TILELAYER.SECONDARY_B (2)
	];
	
	obj_game.tile_heights = global.tile_generated_height_data[? _sprite_id];
	obj_game.tile_widths = global.tile_generated_width_data[? _sprite_id];
	obj_game.tile_angles = global.tile_generated_angle_data[? _sprite_id];
}