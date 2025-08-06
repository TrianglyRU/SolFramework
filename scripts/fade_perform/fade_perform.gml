/// @self
/// @description Configures and triggers a screen fade effect. If unsure, use pre-configured fade functions.
/// @param {Enum.FADEROUTINE} _routine The type of fade action (e.g., fade-in or fade-out).
/// @param {Enum.FADETYPE} _type The blending type of the fade effect.
/// @param {Real} _speed The speed at which the fade occurs.
/// @param {Real} [_frequency] The number of game steps between display updates (default is 1).
/// @param {Bool} [_game_control] Whether to pause game updates during the fade (default is true).
function fade_perform(_routine, _type, _speed, _frequency = 1, _game_control = true)
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
	obj_game.fade_routine = _routine;
	obj_game.fade_game_control = _game_control;
	
	if (_speed = 0)
	{
		if (_game_control)
		{
			obj_game.state = _routine == FADEROUTINE.IN ? GAMESTATE.NORMAL : GAMESTATE.PAUSED;
		}
			
		obj_game.fade_timer = _routine == FADEROUTINE.IN ? FADE_TIMER_MAX : 0;
	}
	else
	{
		obj_game.fade_timer = _routine == FADEROUTINE.IN ? 0 : FADE_TIMER_MAX;
	}
}