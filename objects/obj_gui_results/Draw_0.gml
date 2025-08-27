if (state == RESULTSSTATE.LOAD)
{
    return;
}

var _x, _y;
var _w = camera_get_width(view_current);
var _h = camera_get_height(view_current);
var _centre_x = _w * 0.5;
var _centre_y = _h * 0.5;
var _factor_x = _w / 320;
var _is_single_act = obj_rm_stage.act_id == ACT_SINGLE;
var _player_text;

switch (player_object.player_type)
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

// Create a surface
if (!surface_exists(temp_surface[view_current]))
{
	temp_surface[view_current] = surface_create(_w, _h);
}

// Draw results to that surface with the palette shader applied
surface_set_target(temp_surface[view_current]);
draw_clear_alpha(c_black, 0);
shader_palette_map(view_current);

_x = _centre_x + offset_line1 * _factor_x;
_y = _centre_y - 56;

if (!_is_single_act && player_object.player_type == PLAYER.KNUCKLES)
{
    _x -= 28;
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

if (continue_timer > 60)
{
	var _timer = (continue_timer - 2) % 32;
	if (_timer >= 16 && _timer < 32)
	{
		var _sprite;
		var _index = view_current > 0 ? global.player_cpu : global.player_main;
		
		switch (_index)
		{
			case PLAYER.TAILS:
				_sprite = spr_gui_continue_tails;
			break;
			
			case PLAYER.KNUCKLES:
				_sprite = spr_gui_continue_knuckles;
			break;
			
			case PLAYER.AMY:
				_sprite = spr_gui_continue_amy;
			break;
			
			default:
				_sprite = spr_gui_continue_sonic;
		}
		
		_x = _centre_x + 112;
		_y = _centre_y + 52;
		
		draw_sprite(_sprite, floor(continue_timer / 20) % 2, _x, _y);
	}
}

shader_reset();
surface_reset_target();

// Now draw the surface to the view surface
_x = camera_get_x(view_current);
_y = camera_get_y(view_current);

draw_surface(temp_surface[view_current], _x, _y);