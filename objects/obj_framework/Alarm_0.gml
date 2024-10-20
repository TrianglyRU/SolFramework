// TODO: LTS'25: restore OF2 behaviour
if (global.start_fullscreen)
{
	window_set_fullscreen(true);
}

room_goto(global.start_room);