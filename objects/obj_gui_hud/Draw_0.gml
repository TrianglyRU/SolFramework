var _player = player_get(view_current);

if (_player == noone)
{
	exit;
}

var _camera_x = camera_get_x(view_current);
var _camera_y = camera_get_y(view_current);
var _height = camera_get_height(view_current);
var _x = 0;
var _y = 0;

draw_set_font(global.font_data[? spr_font_digits]);

_x = _camera_x + 36 + score_offset;
_y = _camera_y + 14;

draw_sprite(spr_gui_hud_score, 0, _x, _y);
draw_set_halign(fa_right);
draw_text(_x + 77, _y - 5, global.score_count);

_x = _camera_x + 32 + time_offset;
_y = _camera_y + 30;
	
draw_sprite(spr_gui_hud_time, local_timer < 32400 ? 0 : dynamic_frame, _x, _y);
draw_set_halign(fa_left);
draw_text(_x + 25, _y - 5, timer_string);

_x = _camera_x + 36 + rings_offset;
_y = _camera_y + 46;
	
draw_sprite(spr_gui_hud_rings, global.player_rings > 0 ? 0 : dynamic_frame, _x, _y);	
draw_set_halign(fa_right);
draw_text(_x + 53, _y - 5, global.player_rings);

draw_set_font(global.font_data[? spr_font_digits_small]);

_x = _camera_x + 40 + lives_offset;
_y = _camera_y + _height - 16;

draw_sprite(spr_gui_hud_lives, _player.vd_player_type, _x, _y);	
draw_set_halign(fa_right);
draw_text(_x + 25, _y + 1, global.life_count);