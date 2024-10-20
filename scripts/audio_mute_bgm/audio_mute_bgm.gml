/// @self
/// @description Mutes BGM on the specified channel over a given duration.
/// @param {Real} _time The duration in seconds to mute the BGM.
/// @param {Real} [_index] The channel index (default is 0).
function audio_mute_bgm(_time, _index = 0)
{
    with (obj_framework)
    {
        if (audio_channel_bgms[_index] == -1)
		{
			return;
		}
        
        if (audio_channel_states[_index] != CHANNELSTATE.TEMPMUTE)
        {
            audio_channel_states[_index] = CHANNELSTATE.MUTE;
        }
        
        audio_sound_gain(audio_channel_bgms[_index], 0, _time * 1000);
    }
}