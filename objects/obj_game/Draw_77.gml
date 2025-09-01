/// @description Draw Camera Views

if room == rm_startup
{
	return;
}

gpu_set_blendenable(false);

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera_data = camera_get_data(_i);
	
	if _camera_data == undefined
	{
		continue;
	}
	
	// All surfaces should exist by this point, see End Step -> CAMERA
	var _surface = view_surface_id[_i];
	var _palette_surface = view_surface_palette[_i];
	var _fade_surface = view_surface_final[_i];
	
	// Draw the view surface to the first temporary surface with the palette shader applied
	surface_set_target(_palette_surface);
	draw_clear_alpha(c_black, 0);
	shader_palette_map(_i);
	draw_surface(_surface, 0, 0);
	shader_reset();
	surface_reset_target();
	
	// Now draw that to the second temporary surface with the fade shader applied
	surface_set_target(_fade_surface);
	draw_clear_alpha(c_black, 0);
	shader_rgb_fade();
	draw_surface(_palette_surface, 0, 0);
	shader_reset();
	surface_reset_target();
	
	// Draw the final result to the application surface
	surface_set_target(application_surface);
	draw_surface_part(_fade_surface, CAMERA_HORIZONTAL_BUFFER, 0, surface_get_width(_surface) - CAMERA_HORIZONTAL_BUFFER * 2, surface_get_height(_surface), _camera_data.surface_x, _camera_data.surface_y);
	surface_reset_target();
}

gpu_set_blendenable(true);