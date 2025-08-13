enum RESULTSSTATE
{
	LOAD,
	MOVE,
	TALLY,
	WAIT_EXIT,
	EXIT
}

obj_game.allow_pause = false;

offset_line1 = -256;
offset_line2 = 256;
offset_time = 512;
offset_rings = 528;
offset_perfect = 544;
offset_total = 560;
speed_x = 16;
state = RESULTSSTATE.LOAD;
state_timer = 40;
total_bonus = 0;
ring_bonus = global.player_rings * 100;
player_object = player_get(0);

audio_play_bgm(snd_bgm_actclear);

var _stage_time = obj_gui_hud.local_timer;
if (_stage_time < 1800)			// < 0:30
{
	time_bonus = 50000;
}
else if (_stage_time < 2700)	// < 0:45
{
	time_bonus = 10000;
}
else if (_stage_time < 3600)	// < 1:00
{
	time_bonus = 5000;
}
else if (_stage_time < 5400)	// < 1:30
{
	time_bonus = 4000;
}
else if (_stage_time < 7200)	// < 2:00
{
	time_bonus = 3000;
}
else if (_stage_time < 10800)	// < 3:00
{
	time_bonus = 2000;
}
else if (_stage_time < 14400)	// < 4:00
{
	time_bonus = 1000;
}
else if (_stage_time < 18000)	// < 5:00
{
	time_bonus = 500;
}
else							// >= 5:00
{
	time_bonus = 0;
}