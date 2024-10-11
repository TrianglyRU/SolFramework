var _width = camera_get_width(view_current);
var _height = camera_get_height(view_current);
var _centre_x = camera_get_x(view_current) + _width / 2;
var _centre_y = camera_get_y(view_current) + _height / 2;
var _factor_x = _width / 320;
var _factor_y = _height / 224;

draw_fade_toggle(false);
draw_set_font(global.font_data[? spr_font_large]);
draw_set_halign(fa_right);

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
draw_fade_toggle(true);