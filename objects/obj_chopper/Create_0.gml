// Inherit the parent event
event_inherited();

#macro CHOPPER_VEL_Y_DEFAULT -7

depth = m_get_layer_depth(50);
outside_action = OUTSIDE_ACTION.RESPAWN;
vel_y = CHOPPER_VEL_Y_DEFAULT;