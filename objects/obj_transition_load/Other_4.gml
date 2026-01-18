var _transition_data = global.stage_transition_data;

if _transition_data == undefined
{
	return;
}

var _x = x;
var _y = y;
var _player_data = _transition_data.player_data;

with obj_player
{
	var _data = _player_data[player_index];
	
	if _data == undefined
	{
		continue;
	}
	
	x = _x - _data.offset_x;
	y = _y - _data.offset_y;
	facing = _data.facing;
	
	if camera_data.index == player_index
	{
		camera_data.raw_x = _x - _data.camera_offset_x;
		camera_data.raw_y = _y - _data.camera_offset_y;
		camera_data.max_vel_x = 0;
	}
}

if _transition_data.background_transition
{
	with obj_game
	{
		bg_distance_x = _transition_data.background_distance_x - other.x;
		bg_distance_y = _transition_data.background_distance_y - other.y;
		bg_scroll_x = _transition_data.background_scroll_x;
		bg_scroll_y = _transition_data.background_scroll_y;
	}
}

x += _transition_data.marker_offset_x;
y += _transition_data.marker_offset_y;
sprite_index = _transition_data.marker_sprite;
depth = _transition_data.marker_depth;
visible = true;

// Clear data
global.stage_transition_data = undefined;