/// @self
/// @feather ignore GM1041
/// @description Registers a sprite asset to play its animation according to the game loop.
/// @param {Asset.GMSprite} _sprite_id The sprite to be registered.
/// @param {Real} _duration The duration for each frame in game steps.
function sprite_set_animation(_sprite_id, _duration)
{
	array_push(obj_framework.sprite_array, _sprite_id, _duration);
}