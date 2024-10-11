/// @description Plays the animation for the object, directly updating the image_index based on the current timer value and the frame duration.
/// @param {Real} _timer The timer value.
/// @param {Real} _duration The duration of one frame of the animation, in game steps.
function image_index_update(_timer, _duration)
{
	image_index = floor(_timer / _duration) % image_number;
}