// Inherit the parent event
event_inherited();

display_timer = 0;

obj_set_priority(0);
obj_set_culling(ACTIVEIF.INBOUNDS_DELETE);
obj_set_anim(sprite_index, 2, 0, 0);