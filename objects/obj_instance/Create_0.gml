// ANIMATOR

anim_frame_change_flag = false;
anim_registered_sprite = sprite_index;
anim_duration = -1;
anim_timer = 0;
anim_loop_count = 0;
anim_order_length = 0;
anim_order_index = 0;
anim_order = [];
anim_end_routine = undefined;
image_speed = 0;

// CULLING

enum CULLING
{
	NONE,
	PAUSEONLY,
	ACTIVE,
	REMOVE,
	SUSPEND,
	ORIGINSUSPEND,
	RESPAWN,
	ORIGINRESPAWN 
}

cull_behaviour = CULLING.ACTIVE;
cull_parent = noone;
cull_respawn_flag = false;
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
	cull_width = sprite_get_width(sprite_index) / 2;
	cull_height = sprite_get_height(sprite_index) / 2;
}

// INTERACT

interact_flag = true;
interact_radius_x = 0;
interact_radius_y = 0;
interact_offset_x = 0;
interact_offset_y = 0;
interact_radius_x_ext = 0;
interact_radius_y_ext = 0;
interact_offset_x_ext = 0;
interact_offset_y_ext = 0;

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