if !instance_exists(player) || !player.is_water_running
{
	audio_stop_sound(snd_water_trail);
	instance_destroy();
}
else if (obj_game.frame_counter + 3) % 16 == 0
{
	audio_play_sfx(snd_water_trail);
}