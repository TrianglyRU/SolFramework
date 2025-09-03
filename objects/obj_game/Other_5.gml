/// @description Room End Events
if room == rm_startup
{
	return;
}

global.previous_room_id = room;

// Clear VRAM
draw_texture_flush();