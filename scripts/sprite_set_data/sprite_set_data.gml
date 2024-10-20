/// @self obj_sprite
/// @description Play an animation of a sprite assigned to the object according to the game loop.
/// @param {Real} _duration_data... The duration for each frame in game steps.
function sprite_set_data()
{
	if (argument_count == 0)
	{
		return;
	}
	
	for (var _i = 0; _i < argument_count; _i++)
	{
		array_push(anim_data, argument[_i]);
	}
	
	anim_timer = argument[0];
}