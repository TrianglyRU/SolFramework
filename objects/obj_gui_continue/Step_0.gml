if (!vd_is_screen_space)
{
	return;
}
	
if (display_timer > 60)
{
	var _timer = (display_timer - 1) % 32;
	visible = _timer >= 16 && _timer < 32
}
else if (display_timer == 60)
{
	audio_play_sfx(snd_continue);
	visible = true;
}
	
display_timer++;