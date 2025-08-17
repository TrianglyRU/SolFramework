/// @self
/// @feather ignore GM1041
/// @description Triggers a white fade effect.
/// @param {Enum.FADEDIRECTION} _direction The "direction" of the fade (e.g., fade-in or fade-out).
/// @param {Real} _step_duration The time in game steps between updates of the fade effect, affecting both speed and smoothness.
/// @param {Bool} [_game_control] Whether to pause game updates during the fade (default is true).
/// @param {Real|Function} [_end_routine] A function to execute when the fade routine ends (default is -1).
function fade_perform_white(_direction, _step_duration, _game_control = true, _end_routine = -1)
{
	var _speed = _step_duration > 0 ? (1 / _step_duration) : 0;
	fade_perform
	(
		_direction, _direction == FADEDIRECTION.IN ? FADETYPE.WHITEORDER : FADETYPE.WHITESYNC, _speed, _step_duration, _game_control, _end_routine
	);
}