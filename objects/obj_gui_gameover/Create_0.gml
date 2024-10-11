enum GAMEOVERSTATE
{
	SLIDE_IN,
	WAIT
}

state = GAMEOVERSTATE.SLIDE_IN;
wait_timer = 720;
offset_x = 208;
speed_x = 16;
image_index = global.life_count > 0 && obj_framework.frame_counter >= 36000;
obj_framework.allow_pause = false;

audio_play_bgm(snd_bgm_gameover);