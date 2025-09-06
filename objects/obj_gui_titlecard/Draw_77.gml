/// @description Draw On Application
var _x, _y;

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera_data = camera_get_data(_i);
	
	if _camera_data == undefined
	{
		continue;
	}
	
	var _w = camera_get_width(_i);
	var _h = camera_get_height(_i);
	var _centre_x = _w * 0.5;
	var _centre_y = _h * 0.5;
	var _factor_x = _w / 320;
	var _factor_y = _h / 224;
	
	// Create a surface
	if !surface_exists(temp_surface[_i])
	{
		temp_surface[_i] = surface_create(_w, _h);
	}
	
	// Draw the title card to that surface with the palette shader applied
	surface_set_target(temp_surface[_i]);
	draw_clear_alpha(c_black, 0);
	shader_palette_map(_i);
	
	draw_set_font(global.font_data[? spr_font_large]);
	draw_set_halign(fa_right);

	_x = _centre_x - 64;
	_y = _centre_y - 24 + offset_banner * _factor_y;

	draw_sprite(spr_gui_card_banner, 0, _x, _y);

	_x = _centre_x + 129 + offset_zonename * _factor_x;
	_y = _centre_y - 26;

	draw_text(_x, _y, obj_rm_stage.zone_name);

	_x = _centre_x + 104 + offset_zone * _factor_x;
	_y = _centre_y - 4;

	draw_text(_x, _y, "ZONE");

	_x = _centre_x + 117 + offset_act * _factor_x;
	_y = _centre_y + 12;
	
	draw_sprite(spr_gui_act, obj_rm_stage.act_index, _x, _y);
	draw_set_halign(fa_left);
	
	shader_reset();
	surface_reset_target();
	
	// Now draw the surface to the application surface
	surface_set_target(application_surface);
	draw_surface(temp_surface[_i], _camera_data.surface_x, _camera_data.surface_y);
	surface_reset_target();
}