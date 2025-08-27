/// @self
/// @feather ignore GM1041
/// @description Triggers a flash fade effect.
/// @param {Enum.FADE_DIRECTION} _direction The "direction" of the fade (e.g., fade-in or fade-out).
/// @param {Real} _step_duration The time in game steps between updates of the fade effect, affecting both speed and smoothness.
/// @param {Bool} [_game_control] Whether to pause game updates during the fade (default is true).
/// @param {Real|Function} [_end_method] An argumentless method variable to execute when the fade routine ends (default is -1).
function fade_perform_flash(_direction, _step_duration, _game_control = true, _end_method = -1)
{
	var _speed = _step_duration > 0 ? (1 / _step_duration) : 0;
	var _type = _direction == FADE_DIRECTION.IN ? FADE_TYPE.FLASH_ORDER : FADE_TYPE.FLASH_SYNC;
	
	fade_perform(_direction, _type, _speed, _step_duration, _game_control, _end_method);
}