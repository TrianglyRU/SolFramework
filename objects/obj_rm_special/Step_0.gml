if (state = SPECIALSTAGESTATE.RESULTS)
{
    exit;
}

if (obj_game.state == GAMESTATE.PAUSED)
{
    exit;
}

if (state != SPECIALSTAGESTATE.EMERALD)
{
    var _input_press = input_get_pressed(0);
    if (_input_press.action1)
    {
        audio_play_bgm(snd_bgm_emerald);
        state = SPECIALSTAGESTATE.EMERALD;
    }    
    else if (_input_press.start)
    {
		audio_stop_bgm(0.25);
        audio_play_sfx(snd_warp_2);
        fade_perform_white(FADEDIRECTION.OUT, 3,, start_results);  
    }
}
else if (!audio_is_playing(snd_bgm_emerald))
{
	audio_play_sfx(snd_warp_2);
    fade_perform_white(FADEDIRECTION.OUT, 3,, start_results);
}