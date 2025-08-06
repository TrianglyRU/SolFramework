/// @self
/// @description Mutes BGM on the specified channel over a given duration.
/// @param {Real} _time The duration in seconds to mute the BGM.
/// @param {Real} [_index] The channel index (default is 0).
function audio_mute_bgm(_time, _index = 0)
{
	var _bgm_index = obj_game.audio_channel_bgms[_index];
    if (_bgm_index == -1)
	{
		return;
	}
    
    if (obj_game.audio_channel_states[_index] != CHANNELSTATE.TEMPMUTE)
    {
        obj_game.audio_channel_states[_index] = CHANNELSTATE.MUTE;
    }
        
    audio_sound_gain(_bgm_index, 0, _time * 1000);
}