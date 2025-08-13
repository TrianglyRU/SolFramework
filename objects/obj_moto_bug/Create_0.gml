enum MOTOBUGSTATE
{
	INIT,
	WAIT,
	ROAM
}

// Inherit the parent event
event_inherited();

obj_set_priority(5);
obj_set_hitbox(20, 14);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

state = MOTOBUGSTATE.INIT;
move_timer = 0;
smoke_timer = 0;
vel_x = 0;
vel_y = 0;