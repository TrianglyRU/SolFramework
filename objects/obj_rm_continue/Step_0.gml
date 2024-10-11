if (obj_framework.fade_state == FADESTATE.PLAINCOLOUR)
{
    game_save_data(global.current_save_slot);
	
    if (time_left == 0 || continue_count == 0)
    {
        room_goto(global.start_room);
    }
    else
    {
        room_goto(global.previous_room_id);
    }
	
    exit;
}

if (obj_framework.state == FWSTATE.PAUSED)
{
    exit;
}

if (character_main.vel_charge == 0)
{
    if (--time_left == 0)
    {
        fade_perform_black(FADEROUTINE.OUT, 1);
        audio_stop_bgm(0.5);
		
        exit;
    }
}
else if (continue_count > 1)
{
    with (continue_icons[continue_count - 1])
    {
        anim_timer = -1;
        visible = obj_framework.frame_counter % 2 == 0;
    }
}

var _bound = camera_get_width(0) + 64;

if (character_main.x < _bound || character_buddy != noone && character_buddy.x < _bound)
{
    exit;
}

if (global.continue_count > 0)
{
    global.continue_count--;
}

fade_perform_black(FADEROUTINE.OUT, 1);
audio_stop_bgm(0.5);