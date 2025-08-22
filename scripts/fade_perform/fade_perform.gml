/// @self
/// @description Configures and triggers a screen fade effect. If unsure, use pre-configured fade functions.
/// @param {Enum.FADEDIRECTION} _direction The "direction" of the fade (e.g., fade-in or fade-out).
/// @param {Enum.FADETYPE} _type The blending type of the fade effect.
/// @param {Real} _speed The speed at which the fade occurs.
/// @param {Real} [_frequency] The number of game steps between display updates (default is 1).
/// @param {Bool} [_game_control] Whether to pause game updates during the fade (default is true).
/// @param {Real|Function} [_end_method] An argumentless method to execute when the fade routine ends (default is -1).
function fade_perform(_direction, _type, _speed, _frequency = 1, _game_control = true, _end_method = -1)
{
	if (_speed != 0)
	{
		_speed = clamp(_speed * _frequency * FADE_STEP, 0, FADE_TIMER_MAX);
	}
	
	if (_type == FADETYPE.DULLORDER || _type == FADETYPE.DULLSYNC || _type == FADETYPE.FLASHORDER || _type == FADETYPE.FLASHSYNC)
	{
		_speed *= 3;
	}
	
	obj_game.fade_frequency_timer = 0;
	obj_game.fade_frequency_target = _frequency;
	obj_game.fade_type = _type;
	obj_game.fade_step = _speed;
	obj_game.fade_direction = _direction;
	obj_game.fade_game_control = _game_control;
	obj_game.fade_end_method = _end_method;
	
	if (_speed = 0)
	{
		if (_game_control)
		{
			obj_game.state = _direction == FADEDIRECTION.IN ? GAMESTATE.NORMAL : GAMESTATE.PAUSED;
		}
			
		obj_game.fade_timer = _direction == FADEDIRECTION.IN ? FADE_TIMER_MAX : 0;
	}
	else
	{
		obj_game.fade_timer = _direction == FADEDIRECTION.IN ? 0 : FADE_TIMER_MAX;
	}
}