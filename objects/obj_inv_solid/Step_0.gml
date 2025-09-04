visible = global.debug_collision > 0;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if _p == 0
	{
		visible |= _player.state == PLAYER_STATE.DEBUG_MODE;
	}
	
	m_solid_object(_player, SOLID_TYPE.FULL);
}