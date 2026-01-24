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
	
	// Restore shield
	global.player_shields[player_index] = _data.shield;
	
	if _data.shield != SHIELD.NONE
	{
		instance_create(x, y, obj_shield, { player: id });
	}
	
	// Re-fill up initial record data
	for (var _i = 0; _i < ds_record_length; _i++)
	{
		record_data(_i);
	}
	
	if camera_data.index == player_index
	{
		camera_data.raw_x = _x - _data.camera_offset_x;
		camera_data.raw_y = _y - _data.camera_offset_y;
		
		// Lock the camera to stay within its dimensions so the players can't leave the screen
		camera_data.left_bound = camera_data.raw_x;
		camera_data.top_bound = camera_data.raw_y;
		camera_data.right_bound = camera_data.left_bound + camera_get_width(player_index);
		camera_data.bottom_bound = camera_data.top_bound + camera_get_height(player_index);
		
		// Reset the maximum x-velocity so it smoothly accelerates back to its initial value later
		camera_data.max_vel_x = 0;
	}
}

// Lock the movement and adjust to the stage boundaries instantly as soon as being unlocked
for (var _i = 0; _i < CAMERA_COUNT; _i++)
{	
	camera_toggle_movement(_i, false); obj_rm_stage.bound_speed[_i] = 65536;
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

if sprite_index != spr_object
{
	visible = true;
}

global.stage_transition_data = undefined;