/// @self
/// @description Stops BGM on the specified channel, fading out the volume over a duration.
/// @param {Real} _time The duration in seconds to fade out the BGM.
/// @param {Real} [_index] The channel index (default is 0).
function audio_stop_bgm(_time, _index = 0)
{
    with (obj_framework)
    {
        if (audio_channel_bgms[_index] != -1)
        {
            audio_channel_states[_index] = CHANNELSTATE.STOP;
            audio_sound_gain(audio_channel_bgms[_index], 0, _time * 1000);
        }
    }
}