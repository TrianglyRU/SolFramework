// Inherit the parent event
event_inherited();

enum ITECARD_STATE
{
	MOVE,
	IDLE
}

state = ITECARD_STATE.MOVE;
wait_timer = 0;
vel_y = -3;
depth -= 1;