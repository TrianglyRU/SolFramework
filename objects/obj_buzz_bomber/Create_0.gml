enum BUZZBOMBERSTATE
{
	ROAM,
	HOVER,
	FIRE
}

#macro BUZZBOMBER_ROAM_TIMER 127

// Inherit the parent event
event_inherited();

state = BUZZBOMBERSTATE.HOVER;
state_timer = 0;
shot_flag = false;

obj_set_priority(4);
obj_set_hitbox(24, 12);
obj_set_culling(CULLING.RESPAWN);