// Inherit the parent event
event_inherited();

obj_set_priority(0);
obj_set_culling(CULLING.REMOVE);
obj_set_anim(sprite_index, 2, [0, 1, 2, 3, 4, 4, 5, 5, 6, 6], function(){ instance_destroy(); });