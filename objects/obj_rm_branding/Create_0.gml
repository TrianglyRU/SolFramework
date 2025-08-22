/// @method load_next_room()
load_next_room = function()
{
	room_goto(rm_level_select);
}

orbinaut_scale = 1.5;
orbinaut_alpha = 0.0;
logo_scale = 1.5;
logo_alpha = 0.0;
logo_offset_x = 16;
digit_offset_x = camera_get_width(0);

fade_perform_black(FADEDIRECTION.IN, 1);