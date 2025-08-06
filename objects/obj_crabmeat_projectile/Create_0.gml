// Inherit the parent event
event_inherited();

vel_x = 1 * image_xscale;
vel_y = -4;
grv = 0.21815;

// Override depth
depth += 2;

obj_set_hitbox(4, 4);
obj_set_anim(sprite_index, 2, 0, 0);