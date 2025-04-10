// Draw on the application surface
var _x = surface_get_width(application_surface) / 2;
var _y = surface_get_height(application_surface) / 2;

shader_set(sh_orbinaut);
draw_palette_toggle(false);
draw_sprite(sprite_index, 0, _x, _y);

if (highlight_timer < 8)
{
    draw_sprite(spr_gui_pause_selection, option_id, _x - 4, _y - 8 + 16 * option_id);
}

draw_palette_toggle(true);
shader_reset();