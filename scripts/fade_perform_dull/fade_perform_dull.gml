// Feather ignore GM1041

/// @self
/// @description								Triggers a dull fade effect.
/// @param {Enum.FADE_DIRECTION} _direction		The "direction" of the fade (e.g., fade-in or fade-out).
/// @param {Real} _step_duration				The time in game steps between updates of the fade effect, affecting both speed and smoothness.
/// @param {Function|Undefined} [_fade_action]	A callback function executed once per game step after the fade completes until it returns true or is forcibly cleared (default is undefined).
/// @param {Bool} [_game_control]				Whether to pause game updates during the fade (default is true).
function fade_perform_dull(_direction, _step_duration, _fade_action = undefined, _game_control = true)
{
	var _speed = _step_duration > 0 ? (1 / _step_duration) : 0;
	var _type = _direction == FADE_DIRECTION.IN ? FADE_TYPE.DULL_SYNC : FADE_TYPE.DULL_ORDER;
	
	fade_perform(_direction, _type, _speed, _step_duration, _fade_action, _game_control);
}