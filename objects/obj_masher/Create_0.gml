#macro MASHER_VEL_Y_DEFAULT -5

// Inherit the parent event
event_inherited();

vel_y = MASHER_VEL_Y_DEFAULT;

obj_set_priority(5);
obj_set_hitbox(12, 16);
obj_set_culling(CULLING.RESPAWN);
obj_set_anim(sprite_index, 8);