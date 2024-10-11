enum RINGSTATE
{
	STATIC,
	DROP,
	ATTRACT
}

// Inherit the parent event
event_inherited();

if (vd_state != RINGSTATE.DROP)
{
	obj_set_priority(1);
	obj_set_culling(CULLING.SUSPEND);
}
else
{
	obj_set_priority(3);
	obj_set_culling(CULLING.REMOVE);
}

obj_set_hitbox(6, 6);