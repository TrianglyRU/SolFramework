// Inherit the parent event
event_inherited();

depth = RENDERER_DEPTH_HIGHEST;
offset_x = array_create(CAMERA_COUNT, undefined);
offset_y = array_create(CAMERA_COUNT, undefined);

var _f = image_index;
var _playback_data =
[
	_f, _f, _f, _f, _f, _f, _f, _f, _f, _f, _f, _f,
	6,  6,  6,  6,  6,  6,  6,  6,
	_f, _f, _f, _f, _f, _f, _f, _f,
	6,  6,  6,  6,  6,  6,  6,  6,
	_f, _f, _f, _f, _f, _f, _f, _f,
	6,  6,  6,  6,  6,  6,  6,  6,
	_f, _f, _f, _f, _f, _f, _f, _f,
];

obj_set_anim(sprite_index, 1, _playback_data, function(){ instance_destroy(); });