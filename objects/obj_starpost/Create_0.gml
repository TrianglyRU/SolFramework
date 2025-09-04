// Inherit the parent event
event_inherited();

enum STARPOST_STATE
{
	IDLE,
	ACTIVE
}

image_index = 1;
depth = m_get_layer_depth(60);
outside_action = OUTSIDE_ACTION.RESPAWN;
state = STARPOST_STATE.IDLE;
lamp_obj = instance_create(x, y - 32, obj_starpost_lamp);