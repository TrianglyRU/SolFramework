// Inherit the parent event
event_inherited();

enum BUZZBOMBERSTATE
{
	ROAM,
	HOVER,
	FIRE
}

depth = m_get_layer_depth(40);
outside_action = OUTSIDE_ACTION.RESPAWN;
state = BUZZBOMBERSTATE.HOVER;
state_timer = 0;
shot_flag = false;
projectile = noone;