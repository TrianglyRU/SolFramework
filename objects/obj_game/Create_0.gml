/// @description Initialisation
if room == rm_startup
{
	return;
}

#region COMMON

enum GAME_STATE
{
	NORMAL, STOP_OBJECTS, PAUSED
}

#macro RINGS_THRESHOLD 100
#macro SCORE_THRESHOLD 50000
#macro ANGLE_RAW_MAX 256
#macro ANGLE_INCREMENT (360 / ANGLE_RAW_MAX)

state = GAME_STATE.NORMAL; 
frame_counter = 0;
oscillation_angle = 0;
player_count = 0;
allow_pause = false;

depth = 16000;

#endregion

#region AUDIO

enum CHANNEL_STATE
{
	DEFAULT, MUTE, TEMP_MUTE, STOP
}

#macro AUDIO_CHANNEL_COUNT 4
#macro AUDIO_CHANNEL_JINGLE (AUDIO_CHANNEL_COUNT - 1)

audio_channel_states = array_create(AUDIO_CHANNEL_COUNT, CHANNEL_STATE.DEFAULT);
audio_channel_bgms = array_create(AUDIO_CHANNEL_COUNT, -1);
audio_emitter_sfx = audio_emitter_create();
audio_emitter_bgm = array_create(AUDIO_CHANNEL_COUNT, undefined);
audio_current_loop_data = array_create(AUDIO_CHANNEL_COUNT, undefined);

// TODO: enable in LTS'26
// audio_bus_sfx = audio_bus_create();
// audio_bus_bgm = audio_bus_create();
// audio_emitter_bus(audio_emitter_sfx, audio_bus_sfx);
audio_emitter_gain(audio_emitter_sfx, global.sound_volume);

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	audio_emitter_bgm[_i] = audio_emitter_create();
	
	// TODO: enable in LTS'26
	// audio_emitter_bus(audio_emitter_bgm[_i], audio_bus_bgm);
	audio_emitter_gain(audio_emitter_bgm[_i], global.music_volume);
}

#endregion

#region BACKGROUND

bg_distance_x = 0;
bg_distance_y = 0;
bg_scroll_x = 0;
bg_scroll_y = 0;

#endregion

#region CAMERA & RENDERER

#macro RENDER_DEPTH_PRIORITY 0
#macro RENDER_DEPTH_HUD -100
#macro RENDER_DEPTH_OVERLAY -200
#macro CAMERA_COUNT 8
#macro CAMERA_HORIZONTAL_BUFFER 8
#macro CAMERA_VIEW_TIMER_DEFAULT 120

var _w = global.init_resolution_w;
var _h = global.init_resolution_h;

camera_data = array_create(CAMERA_COUNT, undefined);
view_surface_palette = array_create(CAMERA_COUNT, -1);
view_surface_final = array_create(CAMERA_COUNT, -1);

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	view_camera[_i] = -1;
	view_visible[_i] = false;
}

surface_resize(application_surface, global.init_resolution_w, global.init_resolution_h);
camera_new(0, _w, _h, _w, _h);

#endregion

#region CULLING

#macro CULLING_ROUND_VALUE 128
#macro CULLING_ADD_WIDTH 320
#macro CULLING_ADD_HEIGHT 288

restore_stopped_objects = function()
{
	var _list_size = ds_list_size(cull_game_paused_list);
	
	if _list_size > 0
	{
		for (var _i = _list_size - 1; _i >= 0; _i--)
		{
			instance_activate_object(cull_game_paused_list[| _i]);
		}
		
		ds_list_clear(cull_game_paused_list);
	}
}

// cull_is_initial_restore = true;
cull_game_paused_list = ds_list_create();

#endregion

#region DEBUG

debug_get_state_name = function()
{
	switch state
	{
		case GAME_STATE.NORMAL: return "NORMAL";
		case GAME_STATE.PAUSED: return "PAUSED";
		case GAME_STATE.STOP_OBJECTS: return "STPOBJ";
		default: return "UNKNOWN";
	}
}

debug_tile_sensors = ds_list_create();
debug_interact = ds_list_create();
debug_solids = ds_list_create();
debug_solids_sides = ds_list_create();
debug_solids_push = ds_list_create();

#endregion

#region DEFORMATION

deformation_data = ds_list_create();
deformation_bound = room_height;

#endregion

#region FADE

enum FADE_STATE
{
    ACTIVE, PLAIN_COLOUR, NONE
}

enum FADE_TYPE
{
    BLACK_ORDER = 0,
	BLACK_SYNC = 1, 
	DULL_ORDER = 2, 
	DULL_SYNC = 3, 
	WHITE_ORDER = 4,
	WHITE_SYNC = 5, 
	FLASH_ORDER = 6, 
	FLASH_SYNC = 7,
	NONE = -1
}

enum FADE_DIRECTION
{
    IN, OUT, NONE
}

#macro FADE_TIMER_MAX 765		// 255 * 3
#macro FADE_STEP 36.4285714286	// 255 / 7

fade_timer = FADE_TIMER_MAX;
fade_direction = FADE_DIRECTION.NONE;
fade_type = FADE_TYPE.NONE;
fade_state = FADE_STATE.NONE;
fade_game_control = false;
fade_step = 0;
fade_frequency_timer = 0;
fade_frequency_target = 0;
fade_in_action = -1;
fade_out_action = -1;

#endregion

#region INPUT

#macro INPUT_SLOT_COUNT 4
#macro INPUT_GAMEPAD_DEADZONE 0.15
#macro INPUT_RUMBLE_LIGHT 0.5
#macro INPUT_RUMBLE_MEDIUM 0.75
#macro INPUT_RUMBLE_STRONG 1

input_rumble_time_left = array_create(INPUT_SLOT_COUNT, 0);
input_list_down = ds_list_create();
input_list_press = ds_list_create();

for (var _i = 0; _i < INPUT_SLOT_COUNT; _i++)
{
	input_list_down[| _i] = input_create();
	input_list_press[| _i] = input_create();
}

#endregion

#region PALETTE

#macro PALETTE_TOTAL_SLOT_COUNT 256

palette_bound = room_height;
palette_durations = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_timers = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 1);
palette_loop_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_end_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_data = array_create(2, undefined);

#endregion

#region SPRITE ANIMATOR

sprite_array = [];
sprite_update_enabled = false;

#endregion

#region TILE COLLISION

enum TILE_LAYER
{
    MAIN = 0,
	PATH_A = 1,
	PATH_B = 2
}

#macro TILE_COUNT 256
#macro TILE_SIZE 16
#macro TILE_EMPTY_ANGLE -4

tile_layers = [];
tile_angles = array_create(TILE_COUNT);
tile_widths = array_create(TILE_COUNT);
tile_heights = array_create(TILE_COUNT);

#endregion