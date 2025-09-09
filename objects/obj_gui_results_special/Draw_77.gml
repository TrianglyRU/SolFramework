if (state == SPECIALRESULTS_STATE.LOAD)
{
    return;
}

var _w = surface_get_width(application_surface);
var _h = surface_get_height(application_surface);
var _dx = _w * 0.5;
var _dy = _h * 0.5;
var _factor_x = _w / 320;
var _x = 0;
var _y = 0;
var _player_text;

_x = _dx + offset_line1 * _factor_x;
_y = _dy - 88;

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
	
	default:
		_player_text = "SONIC";
}

draw_set_font(global.font_data[? spr_font_large_alt]);
draw_set_halign(fa_center);

surface_set_target(application_surface);
shader_rgb_fade();

// Upper text
if (message_super)
{
    draw_text(_x, _y, "NOW " + string(_player_text) + " CAN BE");
}
else if (vd_emerald_earned)
{
    draw_text(_x, _y, string(_player_text) + (global.emerald_count == 7 ? " HAS ALL THE" : " GOT A"));
}

_x = _dx + offset_line2 * _factor_x;
_y = _dy - 70;

// Lower text
if (global.emerald_count >= 7)
{
    draw_text(_x, _y, message_super ? "SUPER " + string(_player_text) : "CHAOS EMERALDS");
}
else
{
    draw_text(_x, _y, vd_emerald_earned ? "CHAOS EMERALD" : "SPECIAL STAGE");
}

_x = _dx + offset_score * _factor_x;
_y = _dy + 32;

draw_set_font(global.font_data[? spr_font_digits_alt]);
draw_set_halign(fa_right);
draw_sprite(spr_gui_results_score_special, 0, _x - 75, _y);
draw_text(_x + 97, _y - 7, total_score);

_x = _dx + offset_rings * _factor_x;
_y = _dy + 56;

draw_sprite(spr_gui_results_rings_special, 0, _x - 75, _y);
draw_text(_x + 97, _y - 7, ring_bonus);

_x = _dx;
_y = _dy - 36;

draw_set_alpha(obj_game.frame_counter % 2 == 0 ? 1 : 0);

for (var _i = 0; _i < global.emerald_count; _i++)
{
    switch (_i)
    {
        case 0: draw_sprite(spr_gui_emerald, _i, _x, _y); break;    
        case 1: draw_sprite(spr_gui_emerald, _i, _x + 24, _y + 12); break;
        case 2: draw_sprite(spr_gui_emerald, _i, _x + 24, _y + 36); break;
        case 3: draw_sprite(spr_gui_emerald, _i, _x, _y + 48); break;
        case 4: draw_sprite(spr_gui_emerald, _i, _x - 24, _y + 36); break;
        case 5: draw_sprite(spr_gui_emerald, _i, _x - 24, _y + 12); break;
        case 6: draw_sprite(spr_gui_emerald, _i, _x, _y + 24); break;
    }
}

draw_set_alpha(1);
shader_reset();
surface_reset_target();