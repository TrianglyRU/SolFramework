var _width = camera_get_width(view_current);
var _height = camera_get_height(view_current);

var _factor_x = _width / 320;	
var _draw_x = camera_get_x(view_current) + _width / 2;
var _draw_y = camera_get_y(view_current) + _height / 2;

draw_sprite(spr_gui_gameover_left, image_index, _draw_x - offset_x * _factor_x, _draw_y);
draw_sprite(spr_gui_gameover_right, 0, _draw_x + offset_x * _factor_x, _draw_y);