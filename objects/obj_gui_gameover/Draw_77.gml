var _width = surface_get_width(application_surface);
var _height = surface_get_height(application_surface);
var _draw_x = _width * 0.5;
var _draw_y = _height * 0.5;
var _factor_x = _width / 320;

surface_set_target(application_surface);
shader_rgb_fade();

draw_sprite(spr_gui_gameover_left, image_index, _draw_x - offset_x * _factor_x, _draw_y);
draw_sprite(spr_gui_gameover_right, 0, _draw_x + offset_x * _factor_x, _draw_y);

shader_reset();
surface_reset_target();