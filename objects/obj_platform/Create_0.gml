// Inherit the parent event
event_inherited();
event_culler();

enum PLATFORM_STATE
{
	MOVE,
	FALL
}

enum PLATFORM_TYPE
{
	DEFAULT,
	FALL,
	HORIZONTAL,
	VERTICAL,
	CIRCULAR
}

depth = draw_depth(50);
culler.action = CULL_ACTION.RESPAWN;
state = PLATFORM_STATE.MOVE;
player_touch = false;
wait_timer = 0;
weight = 0;
vel_y = 0;

// Update position immediately
xprevious = x;
yprevious = y;

event_perform(ev_step, ev_step_normal);