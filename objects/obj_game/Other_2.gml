/// @description Startup

// Common
global.init_resolution_w = room_width;	// See scr_game_setup()
global.init_resolution_h = room_height;
global.looped_audio_data = ds_map_create();
global.tile_stored_width_data = ds_map_create();
global.tile_stored_height_data = ds_map_create();
global.tile_stored_angle_data = ds_map_create();
global.font_data = ds_map_create();
global.gamepad_list = ds_list_create();
global.discord_data = ["", "", "", ""];
global.previous_room_id = room;
global.current_save_slot = undefined;
global.stage_index = 0;
global.debug_collision = false;
global.debug_framework = false;

// Sonic-related
global.player_main = PLAYER.SONIC;
global.player_cpu = PLAYER.NONE;
global.continue_count = 0;
global.emerald_count = 0;
global.score_count = 0;
global.life_count = 3;
global.ring_spill_counter = 0;
global.enable_debug_mode = false;
global.player_rings = 0;
global.ring_sound_counter = 0;
global.selected_level_entry = 0;
global.selected_sound_index = 0;
global.selected_player_index = 0;
global.checkpoint_data = [];
global.giant_ring_data = [];
global.life_rewards = [RINGS_THRESHOLD, SCORE_THRESHOLD];
global.player_shields = array_create(PLAYER_MAX_COUNT, SHIELD.NONE);
global.ds_giant_rings = ds_list_create();
global.stage_transition_data = undefined;

// Game setup
scr_game_setup();
game_load_settings();
randomise();

audio_group_load(audiogroup_global);

if os_type == os_windows
{
	display_set_timing_method(tm_sleep);
}

surface_depth_disable(true);
display_reset(0, global.use_vsync);

window_enable_borderless_fullscreen(false);
window_set_caption(global.window_name);
window_resize();

if global.start_fullscreen
{
	window_set_fullscreen(true);
	window_set_cursor(cr_none);
}

alarm[0] = 20;