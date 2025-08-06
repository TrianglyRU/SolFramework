// Inherit the parent event
event_inherited();

audio_play_sfx(snd_explosion);
obj_set_priority(0);
obj_set_anim(sprite_index, 2, 0, function(){ instance_destroy(); });