/// @self
/// @description								Configures and triggers a screen fade effect. If unsure, use pre-configured fade functions.
/// @param {Enum.FADE_DIRECTION} _direction		The direction of the fade (e.g., fade-in or fade-out).
/// @param {Enum.FADE_TYPE} _type				The blending type of the fade effect.
/// @param {Real} _speed						The speed at which the fade occurs.
/// @param {Real} [_frequency]					The number of game steps between display updates (default is 1).
/// @param {Function|Undefined} [_fade_action]	A callback function executed once per game step after the fade completes until it returns true or is forcibly cleared (default is undefined).
/// @param {Bool} [_game_control]				Whether to pause game updates during the fade (default is true).
function fade_perform(_direction, _type, _speed, _frequency = 1, _fade_action = undefined, _game_control = true)
{
	if _speed != 0
	{
		_speed = clamp(_speed * _frequency * FADE_STEP, 0, FADE_TIMER_MAX);
	}
	
	if _type == FADE_TYPE.DULL_ORDER || _type == FADE_TYPE.DULL_SYNC || _type == FADE_TYPE.FLASH_ORDER || _type == FADE_TYPE.FLASH_SYNC
	{
		_speed *= 3;
	}
	
	obj_game.fade_frequency_timer = 0;
	obj_game.fade_frequency_target = _frequency;
	obj_game.fade_type = _type;
	obj_game.fade_step = _speed;
	obj_game.fade_direction = _direction;
	obj_game.fade_game_control = _game_control;
	
	if _speed == 0
	{
		if _game_control
		{
			obj_game.state = _direction == FADE_DIRECTION.IN ? GAME_STATE.NORMAL : GAME_STATE.PAUSED;
		}
			
		obj_game.fade_timer = _direction == FADE_DIRECTION.IN ? FADE_TIMER_MAX : 0;
	}
	else
	{
		obj_game.fade_timer = _direction == FADE_DIRECTION.IN ? 0 : FADE_TIMER_MAX;
	}
	
	if _fade_action != undefined
	{
		if _direction = FADE_DIRECTION.IN
		{
			obj_game.fade_in_action = _fade_action;
		}
		else
		{
			obj_game.fade_out_action = _fade_action;
		}
	}
}