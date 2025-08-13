/// @description Cleanup
ds_map_destroy(global.looped_audio_data);
ds_map_destroy(global.tile_stored_width_data);
ds_map_destroy(global.tile_stored_height_data);
ds_map_destroy(global.tile_stored_angle_data);
ds_map_destroy(global.font_data);
ds_list_destroy(global.ds_giant_rings);
ds_list_destroy(global.gamepad_list);

global.looped_audio_data = -1;
global.tile_stored_width_data = -1;
global.tile_stored_height_data = -1;
global.tile_stored_angle_data = -1;
global.font_data = -1;
global.ds_giant_rings = -1;
global.gamepad_list = -1;

// Clear VRAM
draw_texture_flush();