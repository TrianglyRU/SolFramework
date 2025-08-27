if (state = SPECIALSTAGESTATE.RESULTS)
{
    return;
}

if (state == SPECIALSTAGESTATE.IDLE)
{
    var _input_press = input_get_pressed(0);
    var _input_held = input_get(0);
	
    if (_input_press.action1)
    { 
		state = _input_held.action2 ? SPECIALSTAGESTATE.ALL_EMERALDS
									: SPECIALSTAGESTATE.EMERALD;
									
		audio_play_bgm(snd_bgm_emerald);
    }    
    else if (_input_press.start)
    {
		audio_stop_bgm(1.0);
        audio_play_sfx(snd_warp_2);
        fade_perform_white(FADE_DIRECTION.OUT, 3,, self.start_results);  
    }
}
else if (!audio_is_playing(snd_bgm_emerald))
{
	audio_play_sfx(snd_warp_2);
    fade_perform_white(FADE_DIRECTION.OUT, 3,, self.start_results);
}