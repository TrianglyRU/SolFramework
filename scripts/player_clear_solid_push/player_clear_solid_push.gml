function player_clear_push(_player, _inst_id)
{
	if _player.set_push_anim_by == _inst_id
	{
		if _player.animation != ANIM.SPIN && _player.animation != ANIM.SPINDASH
		{
			_player.animation = ANIM.MOVE;
		}
		
		_player.set_push_anim_by = noone;
	}
}