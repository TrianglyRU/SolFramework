// Inherit the parent event
event_inherited();
obj_set_hitbox(6, 6);

// Override data
vel_x = -2 * image_xscale;
vel_y = 2;

wait_timer = 12;