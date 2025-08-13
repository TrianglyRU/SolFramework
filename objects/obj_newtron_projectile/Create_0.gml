// Inherit the parent event
event_inherited();

obj_set_hitbox(6, 6);
obj_set_anim(sprite_index, 2, 0, 0);

// Override data
vel_x = -2 * image_xscale;