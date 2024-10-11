/// @self obj_instance
/// @description Determines whether the calling object collides with the specified target object's hitbox.
/// @param {Id.Instance} _target The object instance to check.
/// @param {Bool} [_use_target_ext] If true, checks the target's extra hitbox, otherwise checks the standard hitbox (default is false).
/// @returns {Bool}
function obj_check_hitbox(_target, _use_target_ext = false)
{
	if (_target.object_index == obj_player && _target.state != PLAYERSTATE.CONTROL)
	{
		return false;
	}

	if (!interact_flag || !_target.interact_flag)
	{
		return false;
	}
	
	var _target_rx = _target.interact_radius_x_ext;
	var _target_ry = _target.interact_radius_y_ext;
	var _target_ox = _target.interact_offset_x_ext;
	var _target_oy = _target.interact_offset_y_ext;
	var _hitbox_colour = $0000DC;
	
	if (_target_rx <= 0 || _target_ry <= 0)
	{
		_use_target_ext = false;	
	}
	
	if (!_use_target_ext)
	{
		_target_rx = _target.interact_radius_x;
		_target_ry = _target.interact_radius_y;
		
		if (_target_rx <= 0 || _target_ry <= 0)
		{
			return false;
		}
		
		_target_ox = _target.interact_offset_x;
		_target_oy = _target.interact_offset_y;	
		_hitbox_colour = $FF00DC;
	}
	
	var _target_x = floor(_target.x) + _target_ox;
	var _target_y = floor(_target.y) + _target_oy;
	var _target_l = _target_x - _target_rx;
	var _target_r = _target_x + _target_rx;
	var _target_t = _target_y - _target_ry;
	var _target_b = _target_y + _target_ry;
	
	var _this_x = floor(x) +  interact_offset_x;
	var _this_y = floor(y) + interact_offset_y;
	var _this_l = _this_x - interact_radius_x;
	var _this_r = _this_x + interact_radius_x;
	var _this_t = _this_y - interact_radius_y;
	var _this_b = _this_y + interact_radius_y;
	
	#region DEBUG
	
	if (global.debug_collision == 2)
	{
		var _ds_list = obj_framework.debug_interact;

		if (ds_list_find_index(_ds_list, _target) == -1)
		{
			ds_list_add(_ds_list, _target_l, _target_t, _target_r, _target_b, _hitbox_colour, _target);
		}

		if (ds_list_find_index(_ds_list, id) == -1)
		{
			ds_list_add(_ds_list, _this_l, _this_t, _this_r, _this_b, _hitbox_colour, id);
		}
	}
	
	#endregion
	
	if (_target_r < _this_l || _target_l > _this_r)
	{
		return false;
	}
	
	if (_target_b < _this_t || _target_t > _this_b)
	{
		return false;
	}
	
	_target.interact_flag = false;
	interact_flag = false;
	
	return true;
}