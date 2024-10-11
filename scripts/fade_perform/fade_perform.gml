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
	
	with (obj_framework)
	{
		fade_frequency_timer = 0;
		fade_frequency_target = _frequency;
		fade_type = _type;
		fade_step = _speed;
		fade_routine = _routine;
		fade_game_control = _game_control;
		
		if (_speed = 0)
		{
			if (_game_control)
			{
				state = _routine == FADEROUTINE.IN ? FWSTATE.NORMAL : FWSTATE.PAUSED;
			}
			
			fade_timer = _routine == FADEROUTINE.IN ? FADE_TIMER_MAX : 0;
		}
		else
		{
			fade_timer = _routine == FADEROUTINE.IN ? 0 : FADE_TIMER_MAX;
		}
	}
}