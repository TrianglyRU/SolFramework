enum SPECIALSTAGESTATE
{
	IDLE,
	RESULTS,
	EMERALD,
	ALL_EMERALDS
}

/// @method start_results()
start_results = function()
{
	while (audio_is_playing(snd_warp_2))
	{
		// Wait until snd_warp_2 is no longer playing
	}
	
	var _previous_state = state;
		
	if (state == SPECIALSTAGESTATE.EMERALD)
	{
		global.emerald_count = min(global.emerald_count + 1, 7);
	}
	else if (state == SPECIALSTAGESTATE.ALL_EMERALDS)
	{
		global.emerald_count = 7;
	}
			
	state = SPECIALSTAGESTATE.RESULTS;
			
	bg_clear_all();
	dist_clear_all();
	fade_perform_white(FADEDIRECTION.IN, 0);
	instance_create(0, 0, obj_gui_results_special, { vd_emerald_earned: _previous_state >= SPECIALSTAGESTATE.EMERALD });
}

state = SPECIALSTAGESTATE.IDLE;

audio_play_bgm(snd_bgm_special);
bg_convert("Far_Clouds", 0, 0, 0, 0, 0);
bg_convert("Close_Clouds", 0, 0, -0.05, 0, 0);
discord_set_data("SPECIAL STAGE", "", "");
dist_set_layer(["Close_Clouds"], dist_get_data(EFFECTDATA.LBZ1), undefined, 1.0, 0.25, 144, 239);
fade_perform_white(FADEDIRECTION.IN, 1);