/// @description Toggle Collision Overlay
if (global.dev_mode)
{
	global.debug_collision = (global.debug_collision + 1) % 4;
}