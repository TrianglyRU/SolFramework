/// @description Draw Debug Overlay
if room == rm_startup || !global.debug_framework
{
	return;
}

var _w = display_get_gui_width();
var _h = display_get_gui_height();
var _x = _w - 120;

draw_set_alpha(0.75);
draw_rectangle_colour(_x, 8, _w - 8, 32, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

draw_set_font(global.font_data[? spr_font_system]);
draw_set_halign(fa_left);

draw_text(_x, 8,  "STATE: " + debug_get_state_name());
draw_text(_x, 16, "OBJ:   " + string(instance_number(obj_object)) + " " + string(instance_count));
draw_text(_x, 24, "FPS:   " + string(fps) + " " + string(floor(fps_real)));