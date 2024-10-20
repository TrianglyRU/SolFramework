/// @self obj_instance
/// @description Initialises a new animation if the sprite or duration doesn't match the current one. Optionally, updates the duration of the current animation without resetting it.
/// @param {Asset.GMSprite} _sprite_id The sprite used for the animation.
/// @param {Real} _duration Duration of a single frame in game steps.
/// @param {Real|Array<Real>} _playback_data Starting frame or an array of frame indices for custom playback order.
/// @param {Real|Function} _end_routine A function executed after the last frame or a frame index to loop back to.
/// @param {Bool} _update_duration If true, updates the frame duration without resetting the animation (default is false).
function obj_set_anim(_sprite_id, _duration, _playback_data = 0, _end_routine = 0, _update_duration = false)
{
	sprite_index = _sprite_id;
	image_speed = 0;
	
	if (_sprite_id == anim_registered_sprite && anim_duration != -1)
	{
		if (_update_duration)
		{
			anim_duration = _duration;	
			return;
		}
		
		if (anim_duration == _duration)
		{
			return;
		}
	}
	
    anim_duration = is_array(_duration) ? _duration[0] : _duration;
	anim_registered_sprite = _sprite_id;
    anim_end_routine = _end_routine;
	anim_timer = anim_duration;
	anim_loop_count = 0;
	anim_frame_change_flag = false;
    
    anim_order = [];
    anim_order_length = 0;
    anim_order_index = 0;
	
    if (is_array(_playback_data))
    {
        anim_order = _playback_data;
        anim_order_length = array_length(_playback_data);
        anim_order_index = 0;
        image_index = anim_order[0];
    }
    else
    {
        image_index = _playback_data;
    }
}