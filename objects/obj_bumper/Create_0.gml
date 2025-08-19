#macro BUMPER_FORCE 7 

// Inherit the parent event
event_inherited();

obj_set_priority(1);
obj_set_hitbox(8, 8);
obj_set_culling(ACTIVEIF.INBOUNDS);

hits_left = -1;	