enum SPECIALSTAGESTATE
{
	IDLE,
	EMERALD,
	RESULTS
}

state = SPECIALSTAGESTATE.IDLE;

audio_play_bgm(snd_bgm_special);
fade_perform_white(FADEROUTINE.IN, 1);

bg_add_layer(spr_bg_special_00, 0, 240, 0, 0, 0, 0, 0, 0);
bg_add_layer(spr_bg_special_01, 0, 62, 113, 0, -0.05, 0, 0, 0);
dist_set_bg(dist_get_data(EFFECTDATA.LBZ1), [], 0.25, 144, 239);

discord_set_data("SPECIAL STAGE", "", "");