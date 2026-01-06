if ds_list_find_index(global.ds_giant_rings, id) != -1
{
	instance_destroy();
	return;
}

// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.PAUSE);

enum GIANT_RING_STATE
{
	IDLE,
	ENTRY
}

depth = draw_depth(30);
state = GIANT_RING_STATE.IDLE;
wait_timer = 32;