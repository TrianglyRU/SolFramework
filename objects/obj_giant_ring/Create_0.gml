enum GIANTRINGSTATE
{
	IDLE,
	ENTRY,
	TRANSITION
}

if ds_list_find_index(global.ds_giant_rings, id) != -1
{
	instance_destroy();
	exit;
}
	
// Inherit the parent event
event_inherited();

state = GIANTRINGSTATE.IDLE;
wait_timer = 32;
image_xscale = 1;

obj_set_priority(3);
obj_set_hitbox(8, 16);
obj_set_culling(CULLING.SUSPEND);