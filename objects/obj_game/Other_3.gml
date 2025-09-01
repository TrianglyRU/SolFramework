/// @description Global Cleanup

ds_map_destroy(global.looped_audio_data);
ds_map_destroy(global.tile_stored_width_data);
ds_map_destroy(global.tile_stored_height_data);
ds_map_destroy(global.tile_stored_angle_data);
ds_map_destroy(global.font_data);
ds_list_destroy(global.ds_giant_rings);
ds_list_destroy(global.gamepad_list);