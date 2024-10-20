var _width = camera_get_width(0);
var _height = camera_get_height(0);
var _x = _width / 2 - 136;
var _start_y = _height / 2 - 103 + 16;
var _y = _start_y;
var _sound_index = global.selected_sound_index;

draw_set_halign(fa_left);
draw_set_font(global.font_data[? spr_font_small]);

for (var _i = 0; _i < array_length(level_entries); )
{
    var _entry = level_entries[_i];
    
    if (is_regular_entry(_i))
    {
        var _text = string_split(_entry, "|", false);
		var _group_end = _i;
		
		if (_text[0] != "")
		{
			while (_group_end + 1 < array_length(level_entries) && is_regular_entry(_group_end + 1))
			{
				_group_end++;
			}
			
			var _is_selected = global.selected_level_entry >= _i && global.selected_level_entry <= _group_end;
        
	        draw_set_colour(_is_selected ? c_yellow : c_white);
        
	        if (_entry == "SOUND TEST")
	        {
	            draw_text(_x, _y, _entry + "  *" + dec_to_hex(_sound_index) + "*");
	        }
	        else
	        {
	            draw_text(_x, _y, _text[0]);
	        }
		}
		
        if (array_length(_text) > 1)
        {
			var _is_selected = _i == global.selected_level_entry;
			
			draw_set_colour(_is_selected ? c_yellow : c_white);
            draw_text(_x + 120, _y, _text[1]);
        }
		
		draw_set_colour(c_white);
        
        _i++;
    }
    else if (_entry == "/p")
    {
		var _is_selected = level_entries[global.selected_level_entry] != "SOUND TEST";
		
        draw_set_colour(_is_selected ? c_yellow : c_white);
        draw_text(_x + 88, _y, dec_to_hex(global.selected_player_index));
		draw_set_colour(c_white);
		
        _i++;
    }
    else if (_entry == "/n")
    {
        _x += 152;
        _y = _start_y;
        _i++;
		
        continue;
    }
    else
    {
        _i++;
    }
    
    _y += 8;
}