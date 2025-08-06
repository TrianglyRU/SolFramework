/// @self obj_game_object
/// @description Initialises a new animation if the sprite doesn't match the current one, else updates its duration.
/// @param {Asset.GMSprite} _sprite_id The sprite used for the animation.
/// @param {Real} _duration Duration of a single frame in game steps.
/// @param {Real} _start_frame Index of a starting frame.
/// @param {Real|Function} _end_routine A function executed after the last frame or a frame index to loop back to.
function obj_set_anim(_sprite_id, _duration, _start_frame, _end_routine)
{
	sprite_index = _sprite_id;
	image_speed = 0;
	
	// If trying to set the same sprite while the animation is not stopped, simply update the duration
	if (sprite_index == anim_registered_sprite && anim_duration >= 0)
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
	anim_frame_change_flag = false; 
}