if !rendered[view_current]
{
	return;
}

var _camera_x = camera_get_x(view_current);
var _camera_y = camera_get_y(view_current);
var _camera_w = camera_get_width(view_current);
var _camera_h = camera_get_height(view_current);

var _scale = 1;
var _scroll_x = floor(obj_game.bg_scroll_x * scroll_mult_x);
var _scroll_y = floor(obj_game.bg_scroll_y * scroll_mult_y);

var _x = floor((_camera_x + obj_game.bg_distance_x) * (1 - factor_x)) + offset_x - obj_game.bg_distance_x;
var _y = floor((_camera_y + obj_game.bg_distance_y) * (1 - factor_y)) + offset_y - obj_game.bg_distance_y - _scroll_y;

if frame_duration > 0
{
    image_index = floor(obj_game.frame_counter / frame_duration) % image_number;
}

if scale_target_y != -1
{
	// Calculate recommended factor_y
	if factor_y == 0
	{
		show_debug_message(sprite_get_name(sprite_index) + string_format((offset_y - _camera_h * 0.5) / (scale_target_y_init - _camera_h * 0.5), 10, 9));
	}
	
	_scale = clamp((scale_target_y - _y) / height, -1, 1);
}

var _do_line_scroll = line_height >= 0;

if _do_line_scroll
{
	shader_line_scroll(_camera_x + obj_game.bg_distance_x, _scroll_x, _x, _y, width, height, _scale, line_factor_x - factor_x, line_height);
}
else
{
	_x += _scroll_x;
}

if vtiled
{
	draw_sprite_tiled_ext(sprite_index, image_index, _x, _y, 1, _scale, c_white, 1);
}
else if htiled
{
	draw_sprite_tiled_h_ext(sprite_index, image_index, _x, _y, 1, _scale, c_white, 1, -CAMERA_HORIZONTAL_BUFFER, _camera_x + _camera_w);
}
else
{
	draw_sprite_ext(sprite_index, image_index, _x, _y, 1, _scale, 0.0, c_white, 1);
}

if _do_line_scroll
{
	shader_reset();
}