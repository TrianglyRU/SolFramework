instance_destroy();
return;

enum CAPSULESTATE
{
	IDLE,
	BREAK,
	SPAWN_ANIMALS,
	WAIT_ANIMALS
}
	
// Inherit the parent event
event_inherited();

obj_set_priority(4);
obj_set_solid(32, 24);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

obj_rm_stage.end_bound = x + camera_get_width(0) * 0.5;

state = CAPSULESTATE.IDLE;
wait_timer = 0;
button_obj = instance_create_dependent(x, y - 39, obj_capsule_button);
lock_obj = instance_create_dependent(x, y - 23, obj_capsule_lock);
gate_obj = instance_create_dependent(x, y - 3, obj_capsule_gate);