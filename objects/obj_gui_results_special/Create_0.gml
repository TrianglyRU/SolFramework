// Inherit the parent event
event_inherited();

enum SPECIAL_RESULTS_STATE
{
	LOAD,
	MOVE,
	TALLY,
	WAIT_EXIT,
	EXIT,
	SUPER_MSG
}

#macro SPECIAL_RESULTS_OFFSET_LINE_1 -288
#macro SPECIAL_RESULTS_OFFSET_LINE_2  288

offset_line1 = SPECIAL_RESULTS_OFFSET_LINE_1;
offset_line2 = SPECIAL_RESULTS_OFFSET_LINE_2;
offset_score = 528;	
offset_rings = 544;
speed_x = 16;
state = SPECIAL_RESULTS_STATE.LOAD;
state_timer = 20;
message_super = false;
message_emerald = false;
ring_bonus = 50;
total_score = 0;

audio_play_bgm(snd_bgm_act_clear);