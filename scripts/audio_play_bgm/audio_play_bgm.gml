/// @self
/// @description Plays BGM on the specified channel if not already playing.
/// @param {Asset.GMSound} _sound_id The sound asset to play.
/// @param {Real} [_index] The channel index (default is 0).
/// @returns {Id.Sound}
function audio_play_bgm(_sound_id, _index = 0)
{
	var _do_loop = false; // ds_list_find_index(global.looped_audio, _sound_id) != -1;
    var _gain_buffer = 1.0;
    
    with (obj_framework)
    {
        if (audio_channel_states[_index] == CHANNELSTATE.STOP)
        {
            if (audio_channel_bgms[AUDIO_CHANNEL_JINGLE] == -1)
            {
                audio_channel_states[_index] = CHANNELSTATE.DEFAULT;
            }
            else
            {
                audio_channel_states[_index] = CHANNELSTATE.TEMPMUTE;
                _gain_buffer = 0.0;
            }
        }
        else if (audio_channel_bgms[_index] != -1)
        {
            _gain_buffer = audio_sound_get_gain(audio_channel_bgms[_index]);
        }
        
        audio_stop_sound(audio_channel_bgms[_index]);
        audio_channel_bgms[_index] = audio_play_sound_on(audio_emitter_bgm[_index], _sound_id, _do_loop, 0, _gain_buffer);
    }
    
    return obj_framework.audio_channel_bgms[_index];
}