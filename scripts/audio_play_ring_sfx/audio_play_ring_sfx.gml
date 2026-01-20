/// @self
/// @description Plays alternating ring sound effect.
function audio_play_ring_sfx()
{
	if global.ring_sound_counter++ % 2 == 0
	{
		audio_play_sfx(snd_ring_right);
	}
	else
	{
		audio_play_sfx(snd_ring_left);
	}
}