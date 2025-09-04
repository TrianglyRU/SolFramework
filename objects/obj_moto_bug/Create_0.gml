// Inherit the parent event
event_inherited();

enum MOTOBUGSTATE
{
	INIT,
	WAIT,
	ROAM
}

outside_action = OUTSIDE_ACTION.RESPAWN;

depth = m_get_layer_depth(50);
state = MOTOBUGSTATE.INIT;
move_timer = 0;
smoke_timer = 0;
vel_x = 0;
vel_y = 0;