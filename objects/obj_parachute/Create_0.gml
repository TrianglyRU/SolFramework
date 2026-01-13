// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum PARACHUTE_STATE
{
	IDLE,
	CARRY_PLAYER,
	LEFTOVER
}

depth = draw_depth(10);
state = PARACHUTE_STATE.IDLE;
player = noone;
vel_x = 0;
vel_y = 0;