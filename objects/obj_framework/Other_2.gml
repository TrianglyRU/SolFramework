// Set random seed
random_set_seed(randomise());

// Common
global.player_main = PLAYER.NONE;
global.player_cpu = PLAYER.NONE;
global.current_save_slot = -1;
global.stage_index = -1;
global.debug_collision = 0;
global.looped_audio_data = ds_map_create();
global.tile_width_data = ds_map_create();
global.tile_height_data = ds_map_create();
global.tile_angle_data = ds_map_create();
global.font_data = ds_map_create();
global.discord_data = ["", "", "", ""];
global.previous_room_id = room;

// Sonic-related
global.ds_giant_rings = ds_list_create();
global.checkpoint_data = [];
global.giant_ring_data = [];
global.continue_count = 0;
global.emerald_count = 0;
global.life_count = 0;
global.score_count = 0;
global.ring_spill_counter = 0;
global.enable_debug_mode = false;
global.player_rings = 0;
global.player_shields = array_create(PLAYER_MAX_COUNT, SHIELD.NONE);
global.life_rewards = [RINGS_THRESHOLD, SCORE_THRESHOLD];
global.selected_level_entry = 0;
global.selected_sound_index = 0;
global.selected_player_index = 0;

// Shaders
global.sh_fade_active = shader_get_uniform(sh_orbinaut, "u_fade_active");
global.sh_fade_timer = shader_get_uniform(sh_orbinaut, "u_fade_step");
global.sh_fade_type = shader_get_uniform(sh_orbinaut, "u_fade_type");

global.sh_bg_active = shader_get_uniform(sh_orbinaut, "u_bg_active");
global.sh_bg_pos = shader_get_uniform(sh_orbinaut, "u_bg_pos");
global.sh_bg_size = shader_get_uniform(sh_orbinaut, "u_bg_size");
global.sh_bg_scaling = shader_get_uniform(sh_orbinaut, "u_bg_scaling");
global.sh_bg_offset = shader_get_uniform(sh_orbinaut, "u_bg_offset");
global.sh_bg_incline_height = shader_get_uniform(sh_orbinaut, "u_bg_incline_height");
global.sh_bg_incline_step = shader_get_uniform(sh_orbinaut, "u_bg_incline_step");
global.sh_bg_map_size = shader_get_uniform(sh_orbinaut, "u_bg_map_size");

global.sh_pal_active = shader_get_uniform(sh_orbinaut, "u_pal_active");
global.sh_pal_bound = shader_get_uniform(sh_orbinaut, "u_pal_bound");
global.sh_pal_indices = shader_get_uniform(sh_orbinaut, "u_pal_indices");
global.sh_pal_uv_a_global = shader_get_uniform(sh_orbinaut, "u_pal_uv_a_global");
global.sh_pal_texel_size_a_global = shader_get_uniform(sh_orbinaut, "u_pal_texel_size_a_global");
global.sh_pal_tex_a_global = shader_get_sampler_index(sh_orbinaut, "u_pal_tex_a_global");
global.sh_pal_uv_a_local = shader_get_uniform(sh_orbinaut, "u_pal_uv_a_local");
global.sh_pal_texel_size_a_local = shader_get_uniform(sh_orbinaut, "u_pal_texel_size_a_local");
global.sh_pal_tex_a_local = shader_get_sampler_index(sh_orbinaut, "u_pal_tex_a_local");
global.sh_pal_uv_b_global = shader_get_uniform(sh_orbinaut, "u_pal_uv_b_global");
global.sh_pal_texel_size_b_global = shader_get_uniform(sh_orbinaut, "u_pal_texel_size_b_global");
global.sh_pal_tex_b_global = shader_get_sampler_index(sh_orbinaut, "u_pal_tex_b_global");
global.sh_pal_uv_b_local = shader_get_uniform(sh_orbinaut, "u_pal_uv_b_local");
global.sh_pal_texel_size_b_local = shader_get_uniform(sh_orbinaut, "u_pal_texel_size_b_local");
global.sh_pal_tex_b_local = shader_get_sampler_index(sh_orbinaut, "u_pal_tex_b_local");

// Game Setup
scr_framework_setup();

game_load_settings();
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(0);
window_set_caption(global.window_name);
window_set_size(global.init_resolution_w * global.window_scale, global.init_resolution_h * global.window_scale);

application_surface_draw_enable(false);
surface_depth_disable(true);
display_reset(0, global.use_vsync);

// Load into the target room
alarm[0] = 4;