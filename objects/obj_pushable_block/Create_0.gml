// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

enum PUSH_BLOCK_STATE
{
	GROUNDED,
	ON_LEDGE,
	FALLING
}

depth = draw_depth(40);
culler.action = CULL_ACTION.RESET;
state = PUSH_BLOCK_STATE.GROUNDED;
vel_x = 0;
vel_y = 0;