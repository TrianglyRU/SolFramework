// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.RESET);

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

depth = draw_depth(40); // 50 by default
state = PLATFORM_STATE.MOVE;
wait_timer = 0;
weight = 0;
vel_y = 0;

if !variable_instance_exists(id, "synced_objects")
{
	synced_objects = ds_list_create();
}