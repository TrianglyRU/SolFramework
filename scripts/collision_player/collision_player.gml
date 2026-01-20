/// @self
/// @description					Checks collision between the player and a given bounding box.
/// @param {Id.Instance} _player	The player instance to test collision against.
/// @param {Bool} [_use_extra_mask]	Whether to use the player's extra hitbox for collision if available (default is false).
/// @param {Real} [_bbleft]			The maximum left position of the bounding box (default is bbox_left).
/// @param {Real} [_bbtop]			The maximum top position of the bounding box (default is bbox_top).
/// @param {Real} [_bbright]		The maximum right position of the bounding box (default is bbox_right).
/// @param {Real} [_bbbottom]		The maximum bottom position of the bounding box (default is bbox_bottom).
/// @param {Id.Instance} [_inst_id]	The instance performing the collision check (default is the calling instance).
/// @returns {Bool}
function collision_player(_player, _use_extra_mask = false, _bbleft = bbox_left, _bbtop = bbox_top, _bbright = bbox_right, _bbbottom = bbox_bottom, _inst_id = id)
{
	if !_player.interact_flag || _player.state != PLAYER_STATE.DEFAULT
	{
		return false;
	}
	
	var _prev_mask = _player.mask_index;
	
	if _use_extra_mask
	{
		_player.mask_index = _player.extra_mask;
	}
	
	var _result = rectangle_in_rectangle(floor(_player.bbox_left), floor(_player.bbox_top), floor(_player.bbox_right) - 1, floor(_player.bbox_bottom) - 1,
										 floor(_bbleft),		   floor(_bbtop),			floor(_bbright) - 1,		   floor(_bbbottom) - 1);
	
	_player.mask_index = _prev_mask;
	
	if _result
	{
		_player.interact_flag = false;
	}
	
	return _result;
}