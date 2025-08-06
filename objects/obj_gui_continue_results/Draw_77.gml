var _draw_x = surface_get_width(application_surface) * 0.5 + 112;
var _draw_y = surface_get_height(application_surface) * 0.5 + 52;

surface_set_target(application_surface);
shader_rgb_fade();
draw_sprite(sprite_index, image_index, _draw_x, _draw_y);
shader_reset();
surface_reset_target();