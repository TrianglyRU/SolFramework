if (character_main.vel_charge == 0)
{
    if (--time_left == 0)
    {
		audio_stop_bgm(1.0);
        fade_perform_black(FADEDIRECTION.OUT, 1,, self.leave_room);
    }
	
	return;
}

if (continue_count > 1)
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

audio_stop_bgm(1.0);
fade_perform_black(FADEDIRECTION.OUT, 1,, self.leave_room);