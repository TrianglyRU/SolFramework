// Inherit the parent event
event_inherited();
	
transition_flag = false;
timer = 0;
radius = 0;
depth -= 2;

obj_set_hitbox(4, 4);
obj_set_anim(sprite_index, 2);