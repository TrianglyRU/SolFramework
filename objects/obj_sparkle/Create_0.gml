// Inherit the parent event
event_inherited();

obj_set_priority(1);
obj_set_culling(CULLING.REMOVE);
obj_set_anim(sprite_index, 8, 0, function(){ instance_destroy(); });