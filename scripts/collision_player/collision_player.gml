function collision_player(_player, _inst_id = id)
{
	if _player.state != PLAYER_STATE.DEFAULT && _player.state != PLAYER_STATE.DEFAULT_LOCKED || _player.cpu_state == CPU_STATE.RESPAWN || _player.cpu_state == CPU_STATE.RESPAWN_INIT
	{
		return false;
	}
	
	var _px = floor(_player.x);
	var _py = floor(_player.y);
	var _pleft = _px - _player.react_radius_x + _player.react_offset_x;
	var _pright = _px + _player.react_radius_x + _player.react_offset_x;
	var _ptop = _py - _player.react_radius_y + _player.react_offset_y;
	var _pbottom = _py + _player.react_radius_y + _player.react_offset_y;
	
	var _left = floor(bbox_left);
	var _top = floor(bbox_top);
	var _right = floor(bbox_right);
	var _bottom = floor(bbox_bottom);
		
	return rectangle_in_rectangle(_pleft, _ptop, _pright, _pbottom, _left, _top, _right, _bottom);
}