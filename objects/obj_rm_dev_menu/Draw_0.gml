var _width = camera_get_width(0);
var _height = camera_get_height(0);
var _draw_x = _width * 0.5;
var _draw_y = _height * 0.5;
var _options_per_page = 7;
var _current_page = floor(option_id / _options_per_page);
var _last_option_id = min(category_options_count, _current_page * _options_per_page + _options_per_page);

draw_set_font(global.font_data[? spr_font_system]);
draw_set_halign(fa_center);
draw_text(_draw_x, _draw_y - 62, category_data[2]);

for (var _i = _current_page * _options_per_page; _i < _last_option_id; _i++)
{
    var _option_y = _draw_y - 12 + (_i % _options_per_page) * 10;
    var _string = category_data[3 + _i];
	
	if (_i != option_id)
	{
		draw_set_colour(#6D6D6D);
	}
	
    draw_text(_draw_x, _option_y, _string);
	draw_set_colour(c_white);
}