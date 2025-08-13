// ANIMATOR

anim_frame_changed = false;
anim_registered_sprite = sprite_index;
anim_duration = -1;
anim_timer = 0;
anim_play_count = 0;
anim_end_routine = 0;
image_speed = 0;

// CULLING

enum ACTIVEIF
{
    ALWAYS,					// Sol does not perform any culling on the object
    ENGINE_RUNNING,			// Active while the framework is not paused (state != GAMESTATE.PAUSED); otherwise suspended
    OBJECTS_RUNNING,		// Active while object processing is active (state == GAMESTATE.NORMAL); otherwise suspended
	INBOUNDS,				// Active while current x position or x initial position is within active area bounds; otherwise suspended
    INBOUNDS_RESET,			// Active while current x position or x initial position is within active area bounds; otherwise reset to initial state and position
	INBOUNDS_XY,			// Active while current position or initial position is within active area bounds; otherwise suspended
    INBOUNDS_XY_RESET,		// Active while current position or initial position is within active area bounds; otherwise reset to initial state and position
	INBOUNDS_DELETE,		// Active while current position is within active area bounds; otherwise deleted
}

cull_behaviour = ACTIVEIF.OBJECTS_RUNNING;
cull_parent = noone;
cull_is_respawned = false;
cull_reset_object = false;
cull_scale_x = image_xscale;
cull_scale_y = image_yscale;
cull_image = image_index;
cull_sprite = sprite_index;
cull_visible = visible;
cull_depth = depth;
cull_width = 0;
cull_height = 0;

if (sprite_index > 0)
{
	cull_width = sprite_get_width(sprite_index) * 0.5;
	cull_height = sprite_get_height(sprite_index) * 0.5;
}

// INTERACT

hitbox_allow = true;
hitbox_radius_x = 0;
hitbox_radius_y = 0;
hitbox_offset_x = 0;
hitbox_offset_y = 0;

// SOLID

enum SOLIDCOLLISION
{
    NONE,
	TOP,
	BOTTOM,
	LEFT,
	RIGHT,
	ANY,
	PUSH
}

enum SOLIDOBJECT
{
    FULL,
	TOP,
	SIDES,
	ITEMBOX
}

enum SOLIDATTACH
{
    DEFAULT,
	NONE,
	RESET_PLAYER
}

solid_disable_balance = false;
solid_radius_x = 0;
solid_radius_y = 0;
solid_offset_x = 0;
solid_offset_y = 0;
solid_height_map = [];
solid_push_flags = array_create(PLAYER_MAX_COUNT, false);
solid_touch_flags = array_create(PLAYER_MAX_COUNT, SOLIDCOLLISION.NONE);