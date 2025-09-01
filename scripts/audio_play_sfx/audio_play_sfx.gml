/// @self
/// @description Plays a sound effect, stopping any current instance of the same sound asset.
/// @param {Asset.GMSound} _sound_id The sound asset to play.
/// @param {Array<Real>|Undefined} [_loop] The loop points for the sound (default is undefined).
/// @returns {Id.Sound}
function audio_play_sfx(_sound_id, _loop = undefined)
{   
	var _do_loop = _loop != undefined;
	
    if _do_loop
    {
		// TODO: enable in LTS'25
        // audio_sound_loop_start(_soundid, _loop[0]);
        // audio_sound_loop_end(_soundid, _loop[1]);
    }
    
	audio_stop_sound(_sound_id);
	
    return audio_play_sound_on(obj_game.audio_emitter_sfx, _sound_id, _do_loop, 0);
}