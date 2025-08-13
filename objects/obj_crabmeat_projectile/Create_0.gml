// Inherit the parent event
event_inherited();

obj_set_hitbox(4, 4);
obj_set_anim(sprite_index, 2, 0, 0);

// Override data
vel_x = 1 * image_xscale;
vel_y = -4;
grv = 0.21815;
depth += 2;