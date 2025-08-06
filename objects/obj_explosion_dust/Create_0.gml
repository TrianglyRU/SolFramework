// Inherit the parent event
event_inherited();

if (vd_make_sound)
{
	audio_play_sfx(snd_destroy);
}

obj_set_priority(0);
obj_set_anim(sprite_index, 2, 0, function(){ instance_destroy(); });