// Inherit the parent event
event_inherited();

obj_set_priority(0);
obj_set_anim(sprite_index, 2, 0, function(){ instance_destroy(); });
audio_play_sfx(snd_explosion);