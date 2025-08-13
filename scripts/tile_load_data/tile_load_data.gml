/// @self
/// @description Loads calculated collision data associated with the specified tilemap sprite.
/// @param {Asset.GMSprite} _sprite_id The sprite used in the tilemap for which the collision data was calculated.
function tile_load_data(_sprite_id)
{
	obj_game.register_layers();
	obj_game.tile_heights = global.tile_stored_height_data[? _sprite_id];
	obj_game.tile_widths = global.tile_stored_width_data[? _sprite_id];
	obj_game.tile_angles = global.tile_stored_angle_data[? _sprite_id];
}