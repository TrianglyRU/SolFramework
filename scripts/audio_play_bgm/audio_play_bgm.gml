/// @self
/// @description Plays BGM on the specified channel if not already playing.
/// @param {Asset.GMSound} _sound_id The sound asset to play.
/// @param {Real} [_index] The channel index (default is 0).
/// @returns {Id.Sound}
function audio_play_bgm(_sound_id, _index = 0)
{
	// TODO: replace false with ds_list_find_index(global.looped_audio, _sound_id) != -1 in LTS'25
	var _do_loop = false; 
	
    if obj_game.audio_channel_states[_index] == CHANNEL_STATE.STOP
    {
        if obj_game.audio_channel_bgms[AUDIO_CHANNEL_JINGLE] == -1
        {
            obj_game.audio_channel_states[_index] = CHANNEL_STATE.DEFAULT;
        }
        else
        {
            obj_game.audio_channel_states[_index] = CHANNEL_STATE.TEMP_MUTE;
        }
    }
		
    audio_stop_sound(obj_game.audio_channel_bgms[_index]);
		
	var _emitter = obj_game.audio_emitter_bgm[_index];
	var _gain = obj_game.audio_channel_states[_index] == CHANNEL_STATE.TEMP_MUTE ? 0.0 : 1.0;
	
    obj_game.audio_channel_bgms[_index] = audio_play_sound_on(_emitter, _sound_id, _do_loop, 0, _gain);
	obj_game.audio_current_loop_data[_index] = ds_map_find_value(global.looped_audio_data, _sound_id);	// TODO: remove this in LTS'25
    
    return obj_game.audio_channel_bgms[_index];
}