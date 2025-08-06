if (obj_game.fade_state == FADESTATE.PLAINCOLOUR)
{
    room_goto(global.previous_room_id);
	return;
}

if (obj_game.state == GAMESTATE.PAUSED)
{
    return;
}

var _input_press = input_get_pressed(0);
if (_input_press.action1)
{
    audio_play_sfx(snd_ring_left);
    audio_play_sfx(snd_ring_right);
	
	rings_earned += 10;
    global.player_rings = min(global.player_rings + 10, 999);
	
    if (!continue_earned && rings_earned >= 50)
    {
        continue_earned = true;
        global.continue_count++;
		
        audio_play_sfx(snd_continue);
    }
}
else if (_input_press.action2)
{
    var _shield = choose(SHIELD.NORMAL, SHIELD.FIRE, SHIELD.BUBBLE, SHIELD.LIGHTNING);
    for (var _i = 0; _i < PLAYER_MAX_COUNT; _i++)
    {
        global.player_shields[_i] = _shield;
    }
	
    switch (_shield)
    {
        case SHIELD.NORMAL:
            audio_play_sfx(snd_shield);
        break;
		
        case SHIELD.FIRE:
            audio_play_sfx(snd_shield_fire);
        break;
		
        case SHIELD.BUBBLE:
            audio_play_sfx(snd_shield_bubble);
        break;
		
        case SHIELD.LIGHTNING:
            audio_play_sfx(snd_shield_lightning);
        break;
    }
}
else if (_input_press.start )
{
    fade_perform_black(FADEROUTINE.OUT, 1);
    audio_stop_bgm(0.5);
}