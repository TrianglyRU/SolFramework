enum CAPSULESTATE
{
	IDLE,
	BREAK,
	SPAWN_ANIMALS,
	WAIT_ANIMALS
}
	
// Inherit the parent event
event_inherited();

obj_rm_stage.end_bound = x + camera_get_width(0) * 0.5;
state = CAPSULESTATE.IDLE;
wait_timer = 0;

obj_set_priority(4);
obj_set_solid(32, 24);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

button_obj = instance_create(x, y - 39, obj_capsule_button, {}, id);
lock_obj = instance_create(x, y - 23, obj_capsule_lock, {}, id);
gate_obj = instance_create(x, y - 3, obj_capsule_gate, {}, id);