

/*
if obj_game.frame_counter % 2 == 0
{
	// Inherit the parent event
	//event_inherited();
	draw_self();
}

/*
var _ss_position = y - camera_get_y(view_current);

if _ss_position < -sprite_height || _ss_position >= camera_get_height(view_current) + sprite_height
{
	return;
}

var _draw_count = ceil(camera_get_width(view_current) / sprite_width);
var _raw_x = floor(camera_get_x(view_current) / sprite_width);

for (var _i = 0; _i <= _draw_count; _i++)
{
	draw_sprite(sprite_index, image_index, (_raw_x + _i) * sprite_width + sprite_width * 0.5, y);
}
*/