/// @self
/// @description Unmutes BGM on the specified channel, gradually increasing the volume.
/// @param {Real} _time The duration in seconds to fade in the BGM.
/// @param {Real} [_index] The channel index (default is 0).
function audio_unmute_bgm(_time, _index = 0)
{
    with (obj_framework)
    {
        if (audio_channel_bgms[_index] != -1)
        {
            audio_channel_states[_index] = CHANNELSTATE.DEFAULT;
            audio_sound_gain(audio_channel_bgms[_index], 1, _time * 1000);
        }
    }
}