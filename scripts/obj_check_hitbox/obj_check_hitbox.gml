/// @self obj_game_object
/// @description Checks for hitbox collision between the calling object and a player object.
/// @param {Id.Instance} _player The player object instance.
/// @param {Bool} [_check_ext] If true, checks the player's extra hitbox, otherwise checks the standard hitbox (default is false).
/// @returns {Bool}
function obj_check_hitbox(_player, _check_ext = false)
{
	if (_player.state != PLAYERSTATE.DEFAULT)
	{
		return false;
	}

	if (!hitbox_allow || !_player.hitbox_allow)
	{
		return false;
	}
	
	var _player_rx = _player.ext_hitbox_radius_x;
	var _player_ry = _player.ext_hitbox_radius_y;
	var _player_ox = _player.ext_hitbox_offset_x;
	var _player_oy = _player.ext_hitbox_offset_y;
	var _hitbox_colour = $0000DC;
	
	if (_player_rx <= 0 || _player_ry <= 0)
	{
		_check_ext = false;	
	}
	
	if (!_check_ext)
	{
		_player_rx = _player.hitbox_radius_x;
		_player_ry = _player.hitbox_radius_y;
		
		if (_player_rx <= 0 || _player_ry <= 0)
		{
			return false;
		}
		
		_player_ox = _player.hitbox_offset_x;
		_player_oy = _player.hitbox_offset_y;	
		_hitbox_colour = $FF00DC;
	}
	
	var _player_x = floor(_player.x) + _player_ox;
	var _player_y = floor(_player.y) + _player_oy;
	var _player_l = _player_x - _player_rx;
	var _player_r = _player_x + _player_rx;
	var _player_t = _player_y - _player_ry;
	var _player_b = _player_y + _player_ry;
	
	var _this_x = floor(x) +  hitbox_offset_x;
	var _this_y = floor(y) + hitbox_offset_y;
	var _this_l = _this_x - hitbox_radius_x;
	var _this_r = _this_x + hitbox_radius_x;
	var _this_t = _this_y - hitbox_radius_y;
	var _this_b = _this_y + hitbox_radius_y;
	
	#region DEBUG
	
	if (global.debug_collision == 2)
	{
		var _ds_list = obj_game.debug_interact;

		if (ds_list_find_index(_ds_list, _player) == -1)
		{
			ds_list_add(_ds_list, _player_l, _player_t, _player_r, _player_b, _hitbox_colour, _player);
		}
		
		if (ds_list_find_index(_ds_list, id) == -1)
		{
			ds_list_add(_ds_list, _this_l, _this_t, _this_r, _this_b, _hitbox_colour, id);
		}
	}
	
	#endregion
	
	if (_player_r < _this_l || _player_l > _this_r)
	{
		return false;
	}
	
	if (_player_b < _this_t || _player_t > _this_b)
	{
		return false;
	}
	
	_player.hitbox_allow = false;
	hitbox_allow = false;
	
	return true;
}