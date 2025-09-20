// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.RESPAWN);

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
state = PLATFORM_STATE.MOVE;
player_touch = false;
wait_timer = 0;
weight = 0;
vel_y = 0;

if !variable_instance_exists(id, "synced_objects")
{
	synced_objects = ds_list_create();
}

// Update position immediately
xprevious = x;
yprevious = y;

event_perform(ev_step, ev_step_normal);