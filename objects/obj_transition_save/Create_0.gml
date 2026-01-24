// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

save_data = function()
{
	var _player_data = array_create(PLAYER_COUNT, undefined);
	var _marker_offset_x = 0;
	var _marker_offset_y = 0;
	var _marker_sprite = sprite_index;
	var _marker_depth = depth;
	
	var _background_transition = false;
	var _background_distance_x = x;
	var	_background_distance_y = y;
	var	_background_scroll_x = obj_game.bg_scroll_x;
	var	_background_scroll_y = obj_game.bg_scroll_y;
	
	// Carry over background properties from rooms that have their background visible during stage transition
	switch room
	{
		case rm_stage_template:
		case rm_stage_ghz1:
			_background_transition = true;
		break;
	}
	
	if instance_exists(obj_signpost)
	{
		_marker_sprite = obj_signpost.sprite_index;
		_marker_depth = obj_signpost.depth;
		_marker_offset_x = obj_signpost.x - x;
		_marker_offset_y = obj_signpost.y - y;
	}
	
	for (var _p = 0; _p < PLAYER_COUNT; _p++)
	{
		var _player = player_get(_p);
			
		if _player == noone
		{
			continue;
		}
		
		_player_data[_p] =
		{
			offset_x: x - floor(_player.x),
			offset_y: y - floor(_player.y),
			camera_offset_x: x - camera_get_x(_p),
			camera_offset_y: y - camera_get_y(_p),
			facing: _player.facing,
			shield: global.player_shields[_p]
		}
	}
	
	global.stage_transition_data = 
	{
		player_data: _player_data,
		marker_offset_x: _marker_offset_x,
		marker_offset_y: _marker_offset_y,
		marker_sprite: _marker_sprite,
		marker_depth: _marker_depth,
		background_transition: _background_transition,
		background_distance_x: _background_distance_x,
		background_distance_y: _background_distance_y,
		background_scroll_x: _background_scroll_x,
		background_scroll_y: _background_scroll_y
	}
}