if (state == RESULTSSTATE.LOAD)
{
    exit;
}

var _width = camera_get_width(view_current);
var _height = camera_get_height(view_current);
var _centre_x = camera_get_x(view_current) + _width / 2;
var _centre_y = camera_get_y(view_current) + _height / 2;
var _factor_x = _width / 320;
var _x = 0;
var _y = 0;
var _is_single_act = obj_rm_stage.act_id == ACT_SINGLE;

_x = _centre_x + offset_line1 * _factor_x;
_y = _centre_y - 56;

if (!_is_single_act && player_object.vd_player_type == PLAYER.KNUCKLES)
{
    _x -= 28;
}

var _player_text = "SONIC";

switch (player_object.vd_player_type)
{
    case PLAYER.TAILS:
        _player_text = "TAILS";
    break;
	
    case PLAYER.KNUCKLES:
        _player_text = "KNUCKLES";
    break;
	
    case PLAYER.AMY:
        _player_text = "AMY";
    break;
}

draw_set_font(global.font_data[? spr_font_large]);
draw_set_halign(fa_center);
draw_text(_x, _y, string(_player_text) + " GOT");

_x = _centre_x + offset_line2 * _factor_x;
_y = _centre_y - 38;

draw_text(_x - 13 * !_is_single_act, _y, _is_single_act ? "THROUGH ZONE" : "THROUGH ACT");
draw_sprite(spr_gui_act, obj_rm_stage.act_id, _x + 98, _y + 4);

_x = _centre_x + offset_time * _factor_x;
_y = _centre_y + 8;

draw_set_font(global.font_data[? spr_font_digits]);
draw_set_halign(fa_right);
draw_sprite(spr_gui_results_time, 0, _x - 55, _y);
draw_text(_x + 97, _y - 7, time_bonus);

_x = _centre_x + offset_rings * _factor_x;
_y = _centre_y + 24;

draw_sprite(spr_gui_results_rings, 0, _x - 55, _y);
draw_text(_x + 97, _y - 7, ring_bonus);

_x = _centre_x + offset_total * _factor_x;
_y = _centre_y + 56;

draw_sprite(spr_gui_results_score, 0, _x - 55, _y);
draw_text(_x + 97, _y - 7, total_bonus);