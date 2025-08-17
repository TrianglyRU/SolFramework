enum SPECIALSTAGESTATE
{
	IDLE,
	EMERALD,
	RESULTS
}

/// @method start_results()
start_results = function()
{
	while (true)
	{
		if (!audio_is_playing(snd_warp_2))
		{
		    var _give_emerald = state == SPECIALSTAGESTATE.EMERALD;
		    if (_give_emerald && global.emerald_count < 7)
		    {
		        global.emerald_count++;
		    }
			
			state = SPECIALSTAGESTATE.RESULTS;
			bg_clear_all();
			dist_clear_all();
		    fade_perform_white(FADEDIRECTION.IN, 0);
		    instance_create(0, 0, obj_gui_results_special, { EmeraldEarned: _give_emerald });
			
			break;
		}
	}
}

state = SPECIALSTAGESTATE.IDLE;

audio_play_bgm(snd_bgm_special);
bg_convert("Far_Clouds", 0, 0, 0, 0, 0);
bg_convert("Close_Clouds", 0, 0, -0.05, 0, 0);
discord_set_data("SPECIAL STAGE", "", "");
dist_set_layer(["Close_Clouds"], dist_get_data(EFFECTDATA.LBZ1), undefined, 1.0, 0.25, 144, 239);
fade_perform_white(FADEDIRECTION.IN, 1);