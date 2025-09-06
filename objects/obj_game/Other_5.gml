/// @description Room End Events
if room == rm_startup
{
	return;
}

global.previous_rooid = room;

// Clear VRAM
draw_texture_flush();