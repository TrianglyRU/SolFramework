#macro SUPERSTAR_LAST_FRAME image_number - 1

// Inherit the parent event
event_inherited();

image_index = SUPERSTAR_LAST_FRAME;
do_update = false;
attach_to_player = false;

obj_set_priority(1);
obj_set_culling(ACTIVEIF.ENGINE_RUNNING);