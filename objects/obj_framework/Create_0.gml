if (room == rm_startup)
{
	exit;
}

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

// TODO: LTS'24
// audio_bus_sfx = audio_bus_create();
// audio_bus_bgm = audio_bus_create();

audio_emitter_gain(audio_emitter_sfx, global.sound_volume);
// audio_emitter_bus(audio_emitter_sfx, audio_bus_sfx);

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	audio_emitter_bgm[_i] = audio_emitter_create();
	
	audio_emitter_gain(audio_emitter_bgm[_i], global.music_volume);
	// audio_emitter_bus(audio_emitter_bgm[_i], audio_bus_bgm);
}

#endregion

#region BACKGROUND

bg_layer_count = 0;
bg_scroll_offset = 0;
bg_min_factor_y = 0;
bg_parallax_data = [];
bg_perspective_data = [0, 0, 0, -1];	// target_y, target_y (read-only), layer_y, layer_index

#endregion

#region CAMERA

#macro CAMERA_COUNT 8
#macro CAMERA_HORIZONTAL_BUFFER 8
#macro CAMERA_VIEW_TIMER_DEFAULT 120

var _w = global.init_resolution_w;
var _h = global.init_resolution_h;

camera_data = array_create(CAMERA_COUNT, undefined);
view_enabled = true;

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	view_visible[_i] = false;
}

surface_resize(application_surface, _w, _h);
camera_new(0, _w, _h, _w, _h);

#endregion

#region COMMON

enum FWSTATE
{
	NORMAL, PAUSED, STOP_OBJECTS
}

enum DIRECTION
{
    NEGATIVE = -1, POSITIVE = 1
}

enum ROTATION
{
	CLASSIC, MANIA
}

#macro RINGS_THRESHOLD 100
#macro SCORE_THRESHOLD 50000

#macro ANGLE_RAW_MAX 256
#macro ANGLE_INCREMENT (360 / ANGLE_RAW_MAX)

state = FWSTATE.NORMAL; 
frame_counter = 0;
allow_pause = false;
layer = layer_create(15900);

#endregion

#region CULLING

#macro CULLING_ROUND_VALUE 128
#macro CULLING_ADD_WIDTH 320
#macro CULLING_ADD_HEIGHT 288

cull_is_initial = true;
cull_list_pause = ds_list_create();

/// @method cull_restore_paused()
cull_restore_paused = function()
{
	var _list_size = ds_list_size(cull_list_pause);
	
	if (_list_size != 0)
	{
		for (var _i = 0; _i < _list_size; _i++)
		{
			var _object = cull_list_pause[| _i];
			
			instance_activate_object(_object);
			
			if (!cull_is_initial)
			{
				continue;
			}
			
			with (_object)
			{
				if (cull_behaviour <= CULLING.ACTIVE || obj_is_visible())
				{
					continue;
				}
				
				if (cull_behaviour >= CULLING.RESPAWN)
				{
					cull_respawn_flag = true;
				}
					
				// Do not activate back objects outside of the visible camera areas on initial cull
				instance_deactivate_object(id);
			}
		}
	
		ds_list_clear(cull_list_pause);
	}
	
	cull_is_initial = false;
}

#endregion

#region DEBUG

debug_tile_sensors = ds_list_create();
debug_interact = ds_list_create();
debug_solids = ds_list_create();
debug_solids_sides = ds_list_create();
debug_solids_push = ds_list_create();

#endregion

#region DISTORTION

distortion_bound = room_height;
distortion_ranges = array_create(2, [0, room_height]);
distortion_has_data = array_create(2, [false, false]);
distortion_fg_layers = [];
distortion_speeds = [0, 0];
distortion_offsets = [0, 0];
distortion_effects = [-1, -1];

#endregion

#region FADE

enum FADESTATE
{
    ACTIVE, PLAINCOLOUR, NONE
}

enum FADETYPE
{
    BLACKORDER = 0, BLACKSYNC = 1, DULLORDER = 2, DULLSYNC = 3, WHITEORDER = 4, WHITESYNC = 5, FLASHORDER = 6, FLASHSYNC = 7, NONE = 8
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
#macro PALETTE_GLOBAL_SLOT_COUNT 64

palette_bound = room_height;
palette_colours = ds_list_create();
palette_durations = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_timers = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_indexes = array_create(PALETTE_TOTAL_SLOT_COUNT, 1);
palette_loop_indexes = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_end_indexes = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_data = array_create(4, []);

// Load default global palette
pal_load(spr_pal_default_primary, spr_pal_default_secondary);

#endregion

#region RENDERER

#macro RENDERER_DEPTH_HUD 0
#macro RENDERER_DEPTH_HIGHEST 25

#endregion

#region SPRITE ANIMATOR

sprite_array = [];
sprite_update_enabled = true;

#endregion

#region TILE COLLISION

enum TILELAYER
{
    MAIN, SECONDARY, NONE
}

enum TILEBEHAVIOUR
{
    DEFAULT, ROTATE_90, ROTATE_180, ROTATE_270
}

#macro TILE_COUNT 256
#macro TILE_SIZE 16
#macro TILE_EMPTY_ANGLE -4

tile_layers = array_create(2, undefined);
tile_angles = array_create(TILE_COUNT, 0);
tile_widths = array_create(TILE_COUNT);
tile_heights = array_create(TILE_COUNT);

#endregion