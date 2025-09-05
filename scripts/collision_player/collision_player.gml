/// @param {Real} [_bbleft]		The maximum left position of the bounding box (optional, default is bbox_left).
/// @param {Real} [_bbtop]		The maximum top position of the bounding box (optional, default is bbox_top).
/// @param {Real} [_bbright]	The maximum right position of the bounding box (optional, default is bbox_right).
/// @param {Real} [_bbbottom]	The maximum bottom position of the bounding box (optional, default is bbox_bottom).
function collision_player(_player, _bbleft = bbox_left, _bbtop = bbox_top, _bbright = bbox_right, _bbbottom = bbox_bottom, _inst_id = id)
{
	if _player.state != PLAYER_STATE.DEFAULT && _player.state != PLAYER_STATE.DEFAULT_LOCKED
	{
		return false;
	}
	
	if _player.cpu_state == CPU_STATE.RESPAWN || _player.cpu_state == CPU_STATE.RESPAWN_INIT
	{
		return false;
	}
	
	return rectangle_in_rectangle(floor(_player.bbox_left), floor(_player.bbox_top), floor(_player.bbox_right), floor(_player.bbox_bottom),
								  floor(_bbleft),		    floor(_bbtop),			 floor(_bbright),			floor(_bbbottom));
}