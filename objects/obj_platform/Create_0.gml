// Inherit the parent event
event_inherited();

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

outside_action = OUTSIDE_ACTION.RESPAWN;

state = PLATFORM_STATE.MOVE;
player_touch = false;
wait_timer = 0;
weight = 0;
vel_y = 0;
depth = m_get_layer_depth(50);

// Update position immediately
xprevious = x;
yprevious = y;
event_perform(ev_step, ev_step_normal);