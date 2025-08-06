/// Called in obj_game -> End Step -> CULLING
/// @description Parent Check

if (cull_parent != noone && !instance_exists(cull_parent))
{
	instance_destroy();
}