// Inherit the parent event
event_inherited();

depth -= 1;

obj_set_culling(CULLING.REMOVE);
obj_set_anim(sprite_index, 2, 0, 11);