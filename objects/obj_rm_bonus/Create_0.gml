rings_earned = 0;
continue_earned = false;

fade_perform_black(FADEROUTINE.IN, 1);
audio_play_bgm(snd_bgm_bonus);
bg_add_layer(spr_bg_bonus_00, 0, 512, 0, 0, 0.25, 0.25, 0, 0);
discord_set_data("BONUS STAGE", "", "", undefined);