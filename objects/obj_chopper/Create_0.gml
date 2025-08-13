#macro CHOPPER_VEL_Y_DEFAULT -7

// Inherit the parent event
event_inherited();

obj_set_priority(5);
obj_set_hitbox(12, 16);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

vel_y = CHOPPER_VEL_Y_DEFAULT;