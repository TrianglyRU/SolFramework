// Inherit the parent event
event_inherited();

obj_set_priority(0);
obj_set_anim(sprite_index, 1, 0, function(){ visible = false; });

attack_timer = 14;