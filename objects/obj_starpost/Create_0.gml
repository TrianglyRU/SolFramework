enum STARPOSTSTATE
{
	IDLE,
	ACTIVE
}

// Inherit the parent event
event_inherited();

obj_set_priority(6);
obj_set_culling(CULLING.RESPAWN);

state = STARPOSTSTATE.IDLE;
lamp_obj = instance_create(x, y - 32, obj_starpost_lamp, {}, id);