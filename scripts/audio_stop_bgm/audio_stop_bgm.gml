/// @self
/// @description Stops BGM on the specified channel, fading out the volume over a duration.
/// @param {Real} _time The duration in seconds to fade out the BGM.
/// @param {Real} [_index] The channel index (default is 0).
function audio_stop_bgm(_time, _index = 0)
{
	var _bgm_index = obj_game.audio_channel_bgms[_index];
    if (_bgm_index != -1)
    {
		obj_game.audio_channel_states[_index] = CHANNELSTATE.STOP;
        audio_sound_gain(_bgm_index, 0, _time * 1000);	
    }
}