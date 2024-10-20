if (obj_framework.fade_state == FADESTATE.PLAINCOLOUR)
{
    room_goto(rm_level_select);
    return;
}

if (obj_framework.state == FWSTATE.PAUSED)
{
    return;
}

orbinaut_alpha = lerp(orbinaut_alpha, 1.0, 0.05);
orbinaut_scale = lerp(orbinaut_scale, 1.0, 0.125);

if (obj_framework.frame_counter >= 8)
{
    logo_alpha = lerp(logo_alpha, 1.0, 0.05);
    logo_scale = lerp(logo_scale, 1.0, 0.125);
}

if (abs(logo_alpha - 0.15) < 0.01)
{
    audio_play_sfx(snd_branding);
}

digit_offset_x = lerp(digit_offset_x, 1, logo_scale < 1.1 ? 0.25 : 0.0);
logo_offset_x = lerp(logo_offset_x, 1, digit_offset_x < 16 ? 0.25 : 0.0);

if (obj_framework.frame_counter == 96 || input_get_pressed(0).start)
{
    fade_perform_black(FADEROUTINE.OUT, 1);
}