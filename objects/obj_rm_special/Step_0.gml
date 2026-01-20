if obj_game.fade_state != FADE_STATE.NONE || state = SPECIAL_STAGE_STATE.RESULTS
{
	return;
}

if state == SPECIAL_STAGE_STATE.IDLE
{
    var _input_press = input_get_pressed(0);
    var _input_held = input_get(0);
	
    if _input_press.action1
    { 
		state = _input_held.action2 ? SPECIAL_STAGE_STATE.ALL_EMERALDS
									: SPECIAL_STAGE_STATE.EMERALD;
			
		audio_play_bgm(snd_bgm_emerald);
    }
    else if _input_press.start
    {
		audio_stop_bgm(1);
        audio_play_sfx(snd_warp_2);
        fade_perform_white(FADE_DIRECTION.OUT, 3, fade_out_function);  
    }
}
else if !audio_is_playing(snd_bgm_emerald)
{
	audio_play_sfx(snd_warp_2);
    fade_perform_white(FADE_DIRECTION.OUT, 3, fade_out_function);
}