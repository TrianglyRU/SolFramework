/// @self obj_game_object
/// @description Initialises a new animation if the sprite doesn't match the current one, else updates its duration.
/// @param {Asset.GMSprite} _sprite_id The sprite used for the animation.
/// @param {Real} _duration Duration of a single frame in game steps.
/// @param {Real} _start_frame Index of a starting frame.
/// @param {Real|Function} _end_routine A frame index to loop back to (or an argumentless method variable to execute) at the very beginning of the next tick after the last frame has ended.
function obj_set_anim(_sprite_id, _duration, _start_frame, _end_routine)
{
	sprite_index = _sprite_id;
	image_speed = 0;
	
	// If trying to set the same sprite while the animation is not stopped, simply update the duration
	if (anim_registered_sprite == sprite_index && anim_duration >= 0)
	{
		anim_duration = _duration;	
		return;
	}
	
	image_index = _start_frame;
    anim_duration =_duration;
	anim_registered_sprite = _sprite_id;
    anim_end_routine = _end_routine;
	anim_timer = anim_duration;
	anim_play_count = 0;
	anim_frame_changed = false; 
}