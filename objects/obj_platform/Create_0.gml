enum PLATFORMSTATE
{
	MOVE,
	FALL
}

enum PLATFORMTYPE
{
	DEFAULT,
	FALL,
	HORIZONTAL,
	VERTICAL,
	CIRCULAR
}

// Inherit the parent event
event_inherited();

state = PLATFORMSTATE.MOVE;
player_touch = false;
wait_timer = 0;
weight = 0;
vel_y = 0;

xprevious = x;
yprevious = y;

obj_set_priority(5);
obj_set_solid(30, 8);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

event_perform(ev_step, ev_step_normal);