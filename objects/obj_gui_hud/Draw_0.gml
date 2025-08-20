var _x, _y;
var _w = camera_get_width(view_current);
var _h = camera_get_height(view_current);

// Create a surface
if (!surface_exists(temp_surface[view_current]))
{
	temp_surface[view_current] = surface_create(_w, _h);
}

// Draw HUD to that surface with the palette shader applied
surface_set_target(temp_surface[view_current]);
draw_clear_alpha(c_black, 0);
shader_palette_map(view_current);

draw_set_font(global.font_data[? spr_font_digits]);

_x = 36 + score_offset;
_y = 14;

draw_sprite(spr_gui_hud_score, 0, _x, _y);
draw_set_halign(fa_right);
draw_text(_x + 77, _y - 5, global.score_count);

_x = 32 + time_offset;
_y = 30;
	
draw_sprite(spr_gui_hud_time, local_timer < 32400 ? 0 : dynamic_frame, _x, _y);
draw_set_halign(fa_left);
draw_text(_x + 25, _y - 5, timer_string);

_x = 36 + rings_offset;
_y = 46;

draw_sprite(spr_gui_hud_rings, global.player_rings > 0 ? 0 : dynamic_frame, _x, _y);	
draw_set_halign(fa_right);
draw_text(_x + 53, _y - 5, global.player_rings);

draw_set_font(global.font_data[? spr_font_digits_small]);

_x = 40 + lives_offset;
_y = _h - 16;

draw_sprite(spr_gui_hud_lives, view_current > 0 ? global.player_cpu : global.player_main, _x, _y);	
draw_set_halign(fa_right);
draw_text(_x + 25, _y + 1, global.life_count);

shader_reset();
surface_reset_target();

// Now draw the surface to the view surface
_x = camera_get_x(view_current);
_y = camera_get_y(view_current);

draw_surface(temp_surface[view_current], _x, _y);