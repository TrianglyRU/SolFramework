if (room == rm_startup)
{
	exit;
}

#region AUDIO

audio_stop_all();

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	audio_emitter_free(audio_emitter_bgm[_i]);
}

audio_emitter_free(audio_emitter_sfx);

#endregion

#region CAMERA

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	camera_delete(_i);
}

#endregion

#region CULLING

ds_list_destroy(cull_list_pause);
cull_list_pause = -1;

#endregion

#region DEBUG

ds_list_destroy(debug_tile_sensors);
ds_list_destroy(debug_interact);
ds_list_destroy(debug_solids);
ds_list_destroy(debug_solids_push);
ds_list_destroy(debug_solids_sides);

debug_tile_sensors = -1;
debug_interact = -1;
debug_solids = -1;
debug_solids_push = -1;
debug_solids_sides = -1;

#endregion

#region INPUT

ds_list_destroy(input_list_down);
ds_list_destroy(input_list_press);

input_list_down = -1;
input_list_press = -1;

#endregion

#region PALETTE

ds_list_destroy(palette_colours);
palette_colours = -1;

#endregion