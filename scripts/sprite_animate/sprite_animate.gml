/// @description Plays the animation for the object, directly updating the object's image_index.
/// @param {Real} _timer The timer value.
/// @param {Real} _duration The duration of one frame of the animation, in game steps.
function sprite_animate(_timer, _duration)
{
	image_index = floor(_timer / _duration) % image_number;
}