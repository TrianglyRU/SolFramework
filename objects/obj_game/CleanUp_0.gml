/// @description Cleanup
if room == rm_startup
{
	return;
}

// AUDIO

audio_stop_all();

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	audio_emitter_free(audio_emitter_bgm[_i]);
}

audio_emitter_free(audio_emitter_sfx);

// CAMERA

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	camera_delete(_i);
}

// CULLING

ds_list_destroy(cull_game_paused_list);

// DEBUG

ds_list_destroy(debug_tile_sensors);
ds_list_destroy(debug_interact);
ds_list_destroy(debug_solids);
ds_list_destroy(debug_solids_push);
ds_list_destroy(debug_solids_sides);

// DEFORMATION

ds_list_destroy(deformation_data);

// INPUT

ds_list_destroy(input_list_down);
ds_list_destroy(input_list_press);