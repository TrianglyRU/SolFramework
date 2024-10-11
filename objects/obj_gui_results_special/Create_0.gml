enum SPECIALRESULTSSTATE
{
	LOAD,
	MOVE,
	TALLY,
	WAIT_EXIT,
	EXIT,
	SUPER_MSG
}

#macro SPECIALRESULTS_OFFSET_LINE_1 -288
#macro SPECIALRESULTS_OFFSET_LINE_2 288

offset_line1 = SPECIALRESULTS_OFFSET_LINE_1;
offset_line2 = SPECIALRESULTS_OFFSET_LINE_2;
offset_score = 528;	
offset_rings = 544;
speed_x = 16;
state = SPECIALRESULTSSTATE.LOAD;
state_timer = 20;
message_super = false;
ring_bonus = 50;
total_score = 0;

audio_play_bgm(snd_bgm_actclear);