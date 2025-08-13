enum STARPOSTSTATE
{
	IDLE,
	ACTIVE
}

// Inherit the parent event
event_inherited();

obj_set_priority(6);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

image_index = 1;
state = STARPOSTSTATE.IDLE;
lamp_obj = instance_create_child(x, y - 32, obj_starpost_lamp);