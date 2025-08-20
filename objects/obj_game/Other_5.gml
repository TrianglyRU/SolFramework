/// @description Room End Events
if (room == rm_startup)
{
	return;
}

global.previous_room_id = room;

// Force execute Room End Event of room directors
if (state == GAMESTATE.PAUSED)
{
	instance_activate_object(obj_game_director);
	with (obj_game_director)
	{
		event_perform(ev_other, ev_room_end);
	}
}
	
// Clear VRAM
draw_texture_flush();