// Inherit the parent event
event_inherited();

depth -= 1;

obj_set_culling(CULLING.REMOVE);
obj_set_anim(sprite_index, 2, [0, 3, 0, 3, 1, 3, 1, 3, 1, 3, 2, 2], function(){ instance_destroy(); });