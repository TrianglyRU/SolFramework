var _width = camera_get_width(0);
var _height = camera_get_height(0);
var _x = _width * 0.5 - 136;
var _start_y = _height * 0.5 - 103 + 16;
var _y = _start_y;
var _sound_index = global.selected_sound_index;
var _last_entry = array_length(level_entries);

draw_set_halign(fa_left);
draw_set_font(global.font_data[? spr_font_small]);

for (var _i = 0; _i < _last_entry; _i++)
{
	var _text = get_entry_text_array(_i);
	var _main = _text[0];
	
	if (_main == "/n")
	{
	    _x += 152;
	    _y = _start_y;
		
		// Do not add 8 to _y
	    continue;
	}
	else if (_main == "/p")
	{
	    draw_set_colour(level_entries[global.selected_level_entry] != "SOUND TEST" ? c_yellow : c_white);
	    draw_text(_x + 88, _y, dec_to_hex(global.selected_player_index));
		draw_set_colour(c_white);
	}
	else if (_main != "")
	{
		var _group_end = _i;
		while (_group_end + 1 < _last_entry && get_entry_text_array(_group_end + 1) == _main)
		{
			_group_end++;
		}
		
		draw_set_colour(global.selected_level_entry >= _i && global.selected_level_entry <= _group_end ? c_yellow : c_white);
        
		if (_main == "SOUND TEST")
		{
		    draw_text(_x, _y, _main + "  *" + dec_to_hex(_sound_index) + "*");
		}
		else
		{
		    draw_text(_x, _y, _main);
		}
		
	    if (array_length(_text) > 1)
	    {
	        draw_text(_x + 120, _y, _text[1]);
	    }
		
		draw_set_colour(c_white);
	}
	
    _y += 8;
}