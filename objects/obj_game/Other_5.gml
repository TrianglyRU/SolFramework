/// @description Cleanup
global.previous_room_id = room;

if (room == rm_startup)
{
	return;
}

// Clear VRAM
draw_texture_flush();

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

ds_list_destroy(cull_game_paused_list);
cull_game_paused_list = -1;

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

#region DISTORTION

ds_list_destroy(distortion_data);
distortion_data = -1;

#endregion

#region INPUT

ds_list_destroy(input_list_down);
ds_list_destroy(input_list_press);
input_list_down = -1;
input_list_press = -1;

#endregion

#region PALETTE

ds_list_destroy(palette_rotations);
palette_rotations = -1;

#endregion