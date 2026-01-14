// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum MOTO_RALLY_STATE
{
	IDLE,
	MOVE,
	MOVE_FAST
}

depth = draw_depth(50);
state = MOTO_RALLY_STATE.MOVE;
state_timer = 0;