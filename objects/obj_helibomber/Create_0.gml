// Inherit the parent event
event_inherited();

enum HELIBOMBER_STATE
{
	SEARCH,
	FLY_TOWARDS,
	PREPARE,
	SHOOT
}

depth = draw_depth(50);
state = HELIBOMBER_STATE.SEARCH;
state_timer = 0;
blade_timer = 0;
vel_x = 0;
dest_x = 0;
player = noone;