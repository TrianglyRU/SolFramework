if (state != STARPOSTSTATE.IDLE)
{
	return;
}

var _checkpoint_data = global.checkpoint_data;

if (is_not_null_array(_checkpoint_data) && _checkpoint_data[7] >= vd_id)
{
	state = STARPOSTSTATE.ACTIVE;
	lamp_obj.activate();
	
	return;
}

var _player = player_get(0);

if (_player.state >= PLAYERSTATE.NO_CONTROL)
{
	return;
}

var _dist_x = floor(_player.x) - x + 8;
var _dist_y = floor(_player.y) - y + 64;

if (_dist_x < 0 || _dist_x >= 16 || _dist_y < 0 || _dist_y >= 104)
{
	return;
}

global.checkpoint_data =
[
	x,
	y,
	obj_framework.frame_counter, 
	obj_rm_stage.bound_upper[0], 
	obj_rm_stage.bound_lower[0], 
	obj_rm_stage.bound_left[0], 
	obj_rm_stage.bound_right[0],
	vd_id
];

state = STARPOSTSTATE.ACTIVE;
lamp_obj.state = LAMPSTATE.ROTATE;

audio_play_sfx(snd_starpost);

if (global.player_rings >= 20)
{
	for (var _i = 0; _i < 4; _i++)
	{
		instance_create(x, y - 50, obj_starpost_star, { vd_star_id: _i }, id);
	}
}