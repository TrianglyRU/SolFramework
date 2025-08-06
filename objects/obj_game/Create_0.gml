/// @description Initialisation
if (room == rm_startup)
{
	return;
}

#region COMMON

enum GAMESTATE
{
	NORMAL, PAUSED, STOP_OBJECTS
}

enum DIRECTION
{
    NEGATIVE = -1, POSITIVE = 1
}

#macro RINGS_THRESHOLD 100
#macro SCORE_THRESHOLD 50000

#macro ANGLE_RAW_MAX 256
#macro ANGLE_INCREMENT (360 / ANGLE_RAW_MAX)

state = GAMESTATE.NORMAL; 
frame_counter = 0;
allow_pause = false;
depth = 16000;

#endregion

#region AUDIO

enum CHANNELSTATE
{
	DEFAULT, MUTE, TEMPMUTE, STOP
}

#macro AUDIO_CHANNEL_COUNT 4
#macro AUDIO_CHANNEL_JINGLE (AUDIO_CHANNEL_COUNT - 1)

audio_channel_states = array_create(AUDIO_CHANNEL_COUNT, CHANNELSTATE.DEFAULT);
audio_channel_bgms = array_create(AUDIO_CHANNEL_COUNT, -1);
audio_emitter_sfx = audio_emitter_create();
audio_emitter_bgm = array_create(AUDIO_CHANNEL_COUNT, undefined);
audio_current_loop_data = array_create(AUDIO_CHANNEL_COUNT, undefined);

// TODO: enable in LTS'25
// audio_bus_sfx = audio_bus_create();
// audio_bus_bgm = audio_bus_create();
// audio_emitter_bus(audio_emitter_sfx, audio_bus_sfx);
audio_emitter_gain(audio_emitter_sfx, global.sound_volume);

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	audio_emitter_bgm[_i] = audio_emitter_create();
	
	// TODO: enable in LTS'25
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

#region CAMERA

#macro RENDERER_DEPTH_HUD 0
#macro RENDERER_DEPTH_HIGHEST 50

#macro CAMERA_COUNT 8
#macro CAMERA_HORIZONTAL_BUFFER 8
#macro CAMERA_VIEW_TIMER_DEFAULT 120

var _w = global.init_resolution_w;
var _h = global.init_resolution_h;

camera_data = array_create(CAMERA_COUNT, undefined);
view_surface_palette = array_create(CAMERA_COUNT, -1);
view_surface_palette_faded = array_create(CAMERA_COUNT, -1);

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	view_camera[_i] = -1;
	view_visible[_i] = false;
}

camera_new(0, _w, _h, _w, _h);

#endregion

#region CULLING

#macro CULLING_ROUND_VALUE 128
#macro CULLING_ADD_WIDTH 320
#macro CULLING_ADD_HEIGHT 288

cull_game_paused_list = ds_list_create();

#endregion

#region DEBUG

debug_tile_sensors = ds_list_create();
debug_interact = ds_list_create();
debug_solids = ds_list_create();
debug_solids_sides = ds_list_create();
debug_solids_push = ds_list_create();

// Functions
debug_get_game_state_name = function()
{
	switch (state)
	{
		case GAMESTATE.NORMAL: return "NORMAL";
		case GAMESTATE.PAUSED: return "PAUSED";
		case GAMESTATE.STOP_OBJECTS: return "STPOBJ";
	}
	
	return "UNKNOWN";
}

#endregion

#region DISTORTION

#macro DISTORTION_MAX_LAYERS 16

distortion_data = ds_list_create();
distortion_bound = room_height;

#endregion

#region FADE

enum FADESTATE
{
    ACTIVE, PLAINCOLOUR, NONE
}

enum FADETYPE
{
    BLACKORDER = 0, BLACKSYNC = 1, DULLORDER = 2, DULLSYNC = 3, WHITEORDER = 4, WHITESYNC = 5, FLASHORDER = 6, FLASHSYNC = 7, NONE = -1
}

enum FADEROUTINE
{
    IN, OUT, NONE
}

#macro FADE_TIMER_MAX 765		// 255 * 3
#macro FADE_STEP 36.4285714286	// 255 / 7

fade_update = false;
fade_routine = FADEROUTINE.NONE;
fade_type = FADETYPE.NONE;
fade_state = FADESTATE.NONE;
fade_game_control = false;
fade_timer = FADE_TIMER_MAX;
fade_step = 0;
fade_frequency_timer = 0;
fade_frequency_target = 0;

#endregion

#region INPUT

#macro INPUT_SLOT_COUNT 4
#macro INPUT_GAMEPAD_DEADZONE 0.15
#macro INPUT_RUMBLE_LIGHT 0.25
#macro INPUT_RUMBLE_MEDIUM 0.5
#macro INPUT_RUMBLE_STRONG 0.75

input_vibrations = array_create(INPUT_SLOT_COUNT, 0);
input_list_gamepads = ds_list_create();
input_list_down = ds_list_create();
input_list_press = ds_list_create();

for (var _i = 0; _i < INPUT_SLOT_COUNT; _i++)
{
	input_list_down[| _i] = input_create();
	input_list_press[| _i] = input_create();
	gamepad_set_axis_deadzone(_i, INPUT_GAMEPAD_DEADZONE);
}

#endregion

#region PALETTE

#macro PALETTE_TOTAL_SLOT_COUNT 256

palette_bound = room_height;
palette_rotations = ds_list_create();
palette_durations = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_timers = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 1);
palette_loop_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_end_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_data = array_create(2, undefined);

#endregion

#region SPRITE ANIMATOR

sprite_array = [];
sprite_update_enabled = true;

#endregion

#region TILE COLLISION

enum TILELAYER
{
    MAIN,			// ID 0
	SECONDARY_A,	// ID 1
	SECONDARY_B		// ID 2
}

#macro TILE_COUNT 256
#macro TILE_SIZE 16
#macro TILE_EMPTY_ANGLE -4

tile_layers = [];
tile_angles = array_create(TILE_COUNT);
tile_widths = array_create(TILE_COUNT);
tile_heights = array_create(TILE_COUNT);

#endregion