// Inherit the parent event
event_inherited();

obj_set_priority(0);
obj_set_anim(sprite_index, 4, 0, function(){ instance_destroy(); });