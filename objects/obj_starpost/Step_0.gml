if (state != STARPOSTSTATE.IDLE)
{
	return;
}

var _checkpoint_data = global.checkpoint_data;
if (array_length(_checkpoint_data) > 0 && _checkpoint_data[7] >= vd_id)
{
	state = STARPOSTSTATE.ACTIVE;
	lamp_obj.activate();	
	return;
}

var _player = player_get(0);
if (_player.state >= PLAYERSTATE.LOCKED)
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
	obj_game.frame_counter, 
	obj_rm_stage.top_bound[0], 
	obj_rm_stage.bottom_bound[0], 
	obj_rm_stage.left_bound[0], 
	obj_rm_stage.right_bound[0],
	vd_id
];

state = STARPOSTSTATE.ACTIVE;
lamp_obj.state = LAMPSTATE.ROTATE;

if (global.player_rings >= 20)
{
	for (var _i = 0; _i < 4; _i++)
	{
		instance_create_dependent(x, y - 50, obj_starpost_star, { vd_star_id: _i });
	}
}

audio_play_sfx(snd_starpost);