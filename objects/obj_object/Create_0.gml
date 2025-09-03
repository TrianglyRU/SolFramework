enum OUTSIDE_ACTION
{
	PAUSE,
	RESPAWN,
	DESTROY
}

m_get_layer_depth = function(_priority)
{
	return floor(depth_start / 100) * 100 + _priority;
}

/// @param {Asset.GMSprite} _sprite_id	The sprite used for the animation
/// @param {Real} _start_frame			Index of a starting frame
/// @param {Real} _loopback				A frame index to loop back to
/// @param {Real} _frame_durtaion		Duration of a single frame in game steps
m_animation_start = function(_sprite_id, _start_frame, _loopback, _frame_durtaion)
{
	image_speed = 0;
	image_index = _start_frame;
	sprite_index = _sprite_id;
	
	image_duration = _frame_durtaion;
	image_timer = _frame_durtaion;
	image_loopback = _loopback;
	sprite_index_advanced = _sprite_id;
	sprite_play_count = 0;
}

m_animation_restart = function()
{
	image_timer = image_duration;
	sprite_play_count = 0;
	image_speed = 0;
	image_index = 0;
}

ignore_object_stop = false;

sprite_index_start = sprite_index;
image_xscale_start = image_xscale;
image_yscale_start = image_yscale;
image_index_start = image_index;
depth_start = depth;
visible_start = visible;

sprite_play_count = 0;
image_duration = 0;
image_timer = 0;
image_loopback = 0;

outside_respawned = false; 
outside_action = OUTSIDE_ACTION.PAUSE;