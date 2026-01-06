if obj_game.fade_state != FADE_STATE.NONE
{
	return;
}

if character_main.vel_charge != 0
{
    if continue_count > 1
	{
		var _last_icon = continue_icons[continue_count - 1];
	
	    _last_icon.animator.timer = -1;
	    _last_icon.visible = obj_game.frame_counter % 2 == 0;
	}

	var _bound = camera_get_width(0) + 64;

	if character_main.x < _bound || character_buddy != noone && character_buddy.x < _bound
	{
	    return;
	}

	if global.continue_count > 0
	{
	    global.continue_count--;
	}
}
else if --time_left > 0
{
	return;
}

audio_stop_bgm(1);
fade_perform_black(FADE_DIRECTION.OUT, 1, function()
{
	if !audio_is_bgm_playing()
	{
		game_save_data(global.current_save_slot);
	
		if time_left == 0 || continue_count == 0
		{
			global.continue_count = 0;
			global.emerald_count = 0;
		
			room_goto(global.start_room);
		}
		else
		{
			room_goto(global.previous_room_id);
		}
			
		return true;
	}
});