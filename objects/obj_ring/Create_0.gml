// Inherit the parent event
event_inherited();
event_culler();

enum RING_STATE
{
	STATIC,
	DROPPED,
	ATTRACTED
}

depth = draw_depth(10);
state = RING_STATE.STATIC;
vel_x = 0;
vel_y = 0;