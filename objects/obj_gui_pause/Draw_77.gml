/// @description Draw On Application
var _x = surface_get_width(application_surface) * 0.5;
var _y = surface_get_height(application_surface) * 0.5;

surface_set_target(application_surface);
shader_rgb_fade();
draw_sprite(sprite_index, 0, _x, _y);

if highlight_timer < 8
{
    draw_sprite(spr_gui_pause_selection, option_id, _x - 4, _y - 8 + 16 * option_id);
}

shader_reset();
surface_reset_target();