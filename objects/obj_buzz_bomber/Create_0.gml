enum BUZZBOMBERSTATE
{
	ROAM,
	HOVER,
	FIRE
}

// Inherit the parent event
event_inherited();

obj_set_priority(4);
obj_set_hitbox(24, 12);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

state = BUZZBOMBERSTATE.HOVER;
state_timer = 0;
shot_flag = false;