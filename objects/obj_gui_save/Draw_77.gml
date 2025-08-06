surface_set_target(application_surface);
draw_sprite(sprite_index, image_index, surface_get_width(application_surface) - 20, surface_get_height(application_surface) - 16);
surface_reset_target();