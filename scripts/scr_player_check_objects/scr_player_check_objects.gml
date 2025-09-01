function scr_player_check_objects()
{
	if state != PLAYER_STATE.DEFAULT && state != PLAYER_STATE.DEFAULT_LOCKED || cpu_state == CPU_STATE.RESPAWN || cpu_state == CPU_STATE.RESPAWN_INIT
	{
		return;
	}
	
	var _px = floor(x);
	var _py = floor(y);
	var _pleft = _px - react_radius_x;
	var _pright = _px + react_radius_x;
	var _ptop = _py - react_radius_y;
	var _pbottom = _py + react_radius_y;
	
	with obj_game_object
	{
		if mask_index != -1
		{
			var _left = floor(bbox_left);
			var _right = floor(bbox_right);
			var _top = floor(bbox_top);
			var _bottom = floor(bbox_bottom);
			
			if rectangle_in_rectangle(_pleft, _ptop, _pright, _pbottom, _left, _top, _right, _bottom)
			{
				other.touch_object = id;
				break;
			}
		}
	}
}