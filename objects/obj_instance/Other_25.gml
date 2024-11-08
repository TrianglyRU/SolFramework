/// Called in obj_framework -> End Step -> CULLING

if (cull_parent != noone && !instance_exists(cull_parent))
{
	instance_destroy();
}