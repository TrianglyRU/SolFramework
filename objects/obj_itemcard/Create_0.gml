enum ITEMCARDSTATE
{
	MOVE,
	IDLE
}
	
// Inherit the parent event
event_inherited();
	
state = ITEMCARDSTATE.MOVE;
wait_timer = 0;
vel_y = -3;
depth -= 1;