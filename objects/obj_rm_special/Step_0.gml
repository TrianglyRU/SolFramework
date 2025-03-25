if (state = SPECIALSTAGESTATE.RESULTS)
{
    exit;
}

if (obj_framework.fade_state == FADESTATE.PLAINCOLOUR && !audio_is_playing(snd_warp_2))
{
    var _give_emerald = state == SPECIALSTAGESTATE.EMERALD;
	
    if (_give_emerald && global.emerald_count < 7)
    {
        global.emerald_count++;
    }
	
    bg_clear();
    fade_perform_white(FADEROUTINE.IN, 0);
    instance_create(0, 0, obj_gui_results_special, { EmeraldEarned: _give_emerald });
	
    state = SPECIALSTAGESTATE.RESULTS;
}

if (obj_framework.state == FWSTATE.PAUSED)
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
        fade_perform_white(FADEROUTINE.OUT, 3);
        audio_stop_bgm(0.5);
        audio_play_sfx(snd_warp_2);
    }
}
else if (!audio_is_playing(snd_bgm_emerald))
{
    fade_perform_white(FADEROUTINE.OUT, 3);
    audio_play_sfx(snd_warp_2);
}