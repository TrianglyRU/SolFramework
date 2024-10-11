var _width = camera_get_width(view_current);
var _height = camera_get_height(view_current);
var _draw_x = _width / 2;
var _draw_y = _height / 2;

draw_set_font(global.font_data[? spr_font_large]);
draw_set_halign(fa_center);
draw_text(_draw_x, _draw_y - 54, "CONTINUE");

draw_set_font(global.font_data[? spr_font_digits]);
draw_text(_draw_x + 1, _draw_y + 7, (time_left >= 600) ? "10" : "0" + string(floor(time_left / 60)));

draw_sprite(spr_continue_stars, 0, _draw_x, _draw_y + 12);