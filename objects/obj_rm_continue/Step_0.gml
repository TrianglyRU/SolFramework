if (obj_game.fade_state == FADESTATE.PLAINCOLOUR)
{
    game_save_data(global.current_save_slot);
	
    if (time_left == 0 || continue_count == 0)
    {
		global.continue_count = 0;
		global.emerald_count = 0;
		
		// We load into the stage either from Level Select or Main Menu where all other 
		// data is set or overwritten, so don't need to clear anything else here
		
        room_goto(global.start_room);
    }
    else
    {
        room_goto(global.previous_room_id);
    }
	
    return;
}

if (obj_game.state == GAMESTATE.PAUSED)
{
    return;
}

if (character_main.vel_charge == 0)
{
    if (--time_left == 0)
    {
        fade_perform_black(FADEROUTINE.OUT, 1);
        audio_stop_bgm(0.5);
		
        return;
    }
}
else if (continue_count > 1)
{
	var _last_icon = continue_icons[continue_count - 1];
	
    _last_icon.anim_timer = -1;
    _last_icon.visible = obj_game.frame_counter % 2 == 0;
}

var _bound = camera_get_width(0) + 64;

if (character_main.x < _bound || character_buddy != noone && character_buddy.x < _bound)
{
    return;
}

if (global.continue_count > 0)
{
    global.continue_count--;
}

fade_perform_black(FADEROUTINE.OUT, 1);
audio_stop_bgm(0.5);