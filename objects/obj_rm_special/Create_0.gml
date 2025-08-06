enum SPECIALSTAGESTATE
{
	IDLE,
	EMERALD,
	RESULTS
}

state = SPECIALSTAGESTATE.IDLE;

audio_play_bgm(snd_bgm_special);
bg_convert("Far_Clouds", 0, 0, 0, 0, 0);
bg_convert("Close_Clouds", 0, 0, -0.05, 0, 0);
discord_set_data("SPECIAL STAGE", "", "");
dist_set_layer(["Close_Clouds"], dist_get_data(EFFECTDATA.LBZ1), undefined, 1.0, 0.25, 144, 239);
fade_perform_white(FADEROUTINE.IN, 1);