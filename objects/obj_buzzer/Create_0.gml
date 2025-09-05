// Inherit the parent event
event_inherited();

#macro BUZZER_DEFAULT_MOVE_TIMER 256

enum BUZZER_STATE
{
	ROAM,
	SHOOT
}

depth = draw_depth(40);
culler.action = CULL_ACTION.RESPAWN;
state = BUZZER_STATE.ROAM;
move_timer = BUZZER_DEFAULT_MOVE_TIMER;
turn_timer = 0;
shot_timer = 0;
flame_timer = -1;
shot_flag = true;