// Inherit the parent event
event_inherited();

enum ITEM_CARD_STATE
{
	MOVE,
	IDLE
}

state = ITEM_CARD_STATE.MOVE;
wait_timer = 0;
vel_y = -3;
depth -= 1;