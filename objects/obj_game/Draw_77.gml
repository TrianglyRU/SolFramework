/// @description Draw Camera Views
if (room == rm_startup)
{
	return;
}

gpu_set_blendenable(false);

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera_data = camera_get_data(_i);
	if (_camera_data == undefined)
	{
		continue;
	}
	
	var _surface = view_surface_id[_i];
	var _palette_surface = view_surface_palette[_i];
	var _fade_surface = view_surface_palette_faded[_i];
	
	// Draw the camera's own surface onto a first temporary surface with a palette swap applied to it
	surface_set_target(_palette_surface);
	draw_clear_alpha(c_black, 0);
	shader_palette_map(_i);
	draw_surface(_surface, 0, 0);
	shader_reset();
	surface_reset_target();
	
	// Now draw that onto a second temporary surface with a fade effect applied on top of it
	surface_set_target(_fade_surface);
	draw_clear_alpha(c_black, 0);
	shader_rgb_fade();
	draw_surface(_palette_surface, 0, 0);
	shader_reset();
	surface_reset_target();
	
	// Draw the final result onto the application surface
	surface_set_target(application_surface);
	draw_surface_part(_fade_surface, CAMERA_HORIZONTAL_BUFFER, 0, surface_get_width(_surface) - CAMERA_HORIZONTAL_BUFFER * 2, surface_get_height(_surface), _camera_data.surface_x, _camera_data.surface_y);
	surface_reset_target();
}

gpu_set_blendenable(true);