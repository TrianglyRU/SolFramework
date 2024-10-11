// Inherit the parent event
event_inherited();

var _order_data =
[
	0, 0, 0, 
	1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3,
	4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6
];

audio_play_sfx(snd_explosion);
obj_set_priority(0);
obj_set_anim(sprite_index, 2, _order_data, function(){ instance_destroy(); });