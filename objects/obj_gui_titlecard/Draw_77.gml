var _width = surface_get_width(application_surface);
var _height = surface_get_height(application_surface);
var _centre_x = _width * 0.5;
var _centre_y = _height * 0.5;
var _factor_x = _width / 320;
var _factor_y = _height / 224;

draw_set_font(global.font_data[? spr_font_large]);
draw_set_halign(fa_right);

surface_set_target(application_surface);
shader_palette_map(0);

var _x = _centre_x - 64;
var _y = _centre_y - 24 + offset_banner * _factor_y;
draw_sprite(spr_gui_card_banner, 0, _x, _y);

_x = _centre_x + 129 + offset_zonename * _factor_x;
_y = _centre_y - 26;
draw_text(_x, _y, obj_rm_stage.zone_name);

_x = _centre_x + 104 + offset_zone * _factor_x;
_y = _centre_y - 4;
draw_text(_x, _y, "ZONE");

_x = _centre_x + 117 + offset_act * _factor_x;
_y = _centre_y + 12;
draw_sprite(spr_gui_act, obj_rm_stage.act_id, _x, _y);

shader_reset();
surface_reset_target();