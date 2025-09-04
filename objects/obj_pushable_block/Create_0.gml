// Inherit the parent event
event_inherited();

enum PUSH_BLOCK_STATE
{
	GROUNDED,
	ON_LEDGE,
	FALLING
}

outside_action = OUTSIDE_ACTION.RESPAWN;

state = PUSH_BLOCK_STATE.GROUNDED;
vel_x = 0;
vel_y = 0;
depth = m_get_layer_depth(40);