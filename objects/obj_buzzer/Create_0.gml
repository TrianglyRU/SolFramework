enum BUZZERSTATE
{
	ROAM,
	SHOOT
}

#macro BUZZER_DEFAULT_MOVE_TIMER 256

// Inherit the parent event
event_inherited();

state = BUZZERSTATE.ROAM;
move_timer = BUZZER_DEFAULT_MOVE_TIMER;
turn_timer = 0;
shot_timer = 0;
flame_timer = -1;
shot_flag = true;

obj_set_priority(4);
obj_set_hitbox(16, 8);
obj_set_culling(CULLING.RESPAWN);