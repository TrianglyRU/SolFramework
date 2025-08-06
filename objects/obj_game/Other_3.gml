/// @description Cleanup
ds_map_destroy(global.looped_audio_data);
ds_map_destroy(global.tile_generated_width_data);
ds_map_destroy(global.tile_generated_height_data);
ds_map_destroy(global.tile_generated_angle_data);
ds_map_destroy(global.font_data);
ds_list_destroy(global.ds_giant_rings);

global.looped_audio_data = -1;
global.tile_generated_width_data = -1;
global.tile_generated_height_data = -1;
global.tile_generated_angle_data = -1;
global.font_data = -1;
global.ds_giant_rings = -1;

// Clear VRAM
draw_texture_flush();