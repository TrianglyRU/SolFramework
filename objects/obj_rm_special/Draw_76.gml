/// @description Fade-Out End
if obj_game.fade_state == FADE_STATE.PLAIN_COLOUR && !audio_is_bgm_playing() && !audio_is_playing(snd_warp_2)
{
	var _previous_state = state;
		
	if state == SPECIALSTAGESTATE.EMERALD
	{
		global.emerald_count = min(global.emerald_count + 1, 7);
	}
	else if state == SPECIALSTAGESTATE.ALL_EMERALDS
	{
		global.emerald_count = 7;
	}
		
	state = SPECIALSTAGESTATE.RESULTS;
			
	bg_clear_all();
	deform_clear_all();
	fade_perform_white(FADE_DIRECTION.IN, 0);
	instance_create(0, 0, obj_gui_results_special, { vd_emerald_earned: _previous_state >= SPECIALSTAGESTATE.EMERALD });
	room_goto(global.previous_room_id);
}