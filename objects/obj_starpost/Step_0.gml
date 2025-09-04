instance_activate_object(lamp_obj);

if state != STARPOST_STATE.IDLE
{
	return;
}

var _checkpoint_data = global.checkpoint_data;

if array_length(_checkpoint_data) > 0 && _checkpoint_data[7] >= vi_index
{
	state = STARPOST_STATE.ACTIVE;
	lamp_obj.m_activate();
	
	return;
}

var _player = player_get(0);
var _px = floor(_player.x);
var _py = floor(_player.y);

if _player.state < PLAYER_STATE.DEFAULT_LOCKED && point_in_rectangle(_px, _py, bbox_left, bbox_top, bbox_right, bbox_bottom)
{
	global.checkpoint_data =
	[
		x,
		y,
		obj_game.frame_counter, 
		obj_rm_stage.top_bound[0], 
		obj_rm_stage.bottom_bound[0], 
		obj_rm_stage.left_bound[0], 
		obj_rm_stage.right_bound[0],
		vi_index
	];
	
	state = STARPOST_STATE.ACTIVE;
	lamp_obj.state = LAMP_STATE.ROTATE;
	
	if global.player_rings >= 20
	{
		for (var _i = 0; _i < 4; _i++)
		{
			// instance_create(x, y - 50, obj_starpost_star, { vd_star_id: _i });
		}
	}

	audio_play_sfx(snd_starpost);
}
