if (state == SPECIALRESULTSSTATE.LOAD)
{
    return;
}

var _width = camera_get_width(view_current);
var _height = camera_get_height(view_current);
var _centre_x = camera_get_x(view_current) + _width / 2;
var _centre_y = camera_get_y(view_current) + _height / 2;
var _factor_x = _width / 320;
var _draw_x = 0;
var _draw_y = 0;

_draw_x = _centre_x + offset_line1 * _factor_x;
_draw_y = _centre_y - 88;

var _player_text = "SONIC";

switch (global.player_main)
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

draw_set_font(global.font_data[? spr_font_large_alt]);
draw_set_halign(fa_center);

if (message_super)
{
    draw_text(_draw_x, _draw_y, "NOW " + string(_player_text) + " CAN BE");
}
else if (vd_emerald_earned)
{
    draw_text(_draw_x, _draw_y, string(_player_text) + (global.emerald_count == 7 ? " HAS ALL THE" : " GOT A"));
}

_draw_x = _centre_x + offset_line2 * _factor_x;
_draw_y = _centre_y - 70;

if (global.emerald_count >= 7)
{
    draw_text(_draw_x, _draw_y, message_super ? "SUPER " + string(_player_text) : "CHAOS EMERALDS");
}
else
{
    draw_text(_draw_x, _draw_y, vd_emerald_earned ? "CHAOS EMERALD" : "SPECIAL STAGE");
}

_draw_x = _centre_x + offset_score * _factor_x;
_draw_y = _centre_y + 32;

draw_set_font(global.font_data[? spr_font_digits_alt]);
draw_set_halign(fa_right);
draw_sprite(spr_gui_results_score_special, 0, _draw_x - 75, _draw_y);
draw_text(_draw_x + 97, _draw_y - 7, total_score);

_draw_x = _centre_x + offset_rings * _factor_x;
_draw_y = _centre_y + 56;

draw_sprite(spr_gui_results_rings_special, 0, _draw_x - 75, _draw_y);
draw_text(_draw_x + 97, _draw_y - 7, ring_bonus);

_draw_x = _centre_x;
_draw_y = _centre_y - 36;

draw_set_alpha(obj_framework.frame_counter % 2 == 0 ? 1.0 : 0);

for (var _i = 0; _i < global.emerald_count; _i++)
{
    switch _i
    {
        case 0: draw_sprite(spr_gui_emerald, _i, _draw_x, _draw_y); break;    
        case 1: draw_sprite(spr_gui_emerald, _i, _draw_x + 24, _draw_y + 12); break;
        case 2: draw_sprite(spr_gui_emerald, _i, _draw_x + 24, _draw_y + 36); break;
        case 3: draw_sprite(spr_gui_emerald, _i, _draw_x, _draw_y + 48); break;
        case 4: draw_sprite(spr_gui_emerald, _i, _draw_x - 24, _draw_y + 36); break;
        case 5: draw_sprite(spr_gui_emerald, _i, _draw_x - 24, _draw_y + 12); break;
        case 6: draw_sprite(spr_gui_emerald, _i, _draw_x, _draw_y + 24); break;
    }
}

draw_set_alpha(1.0);