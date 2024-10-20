if (state == SPECIALSTAGESTATE.RESULTS)
{
    return;
}

var _half_width = camera_get_width(0) / 2;
var _half_height = camera_get_height(0) / 2;

var _title_string = "* SPECIAL STAGE *";
var _length = string_length(_title_string);

draw_set_font(global.font_data[? spr_font_small]);
draw_set_halign(fa_center);

for (var _i = 0; _i < _length; _i++)
{
    var _offset_x = (_i - round(_length / 2)) * 8 + 8;
    var _offset_y = math_oscillate_y(0, obj_framework.frame_counter * 4, 2, 1, _i * 48);
	
    draw_text(_half_width + _offset_x, 48 + _offset_y, string_char_at(_title_string, _i + 1));
}

if (state == SPECIALSTAGESTATE.EMERALD)
{
    if obj_framework.frame_counter % 20 < 10
    {
        draw_text(_half_width, _half_height + 84, "YOU GOT A CHAOS EMERALD!");
    }  
}
else
{
	draw_text(_half_width, _half_height + 64, "PRESS ACTION 1 TO GET A CHAOS EMERALD");
	draw_text(_half_width, _half_height + 74, "PRESS START TO LEAVE");
}