if !iv_is_decorative
{
	for (var _p = 0; _p < PLAYER_COUNT; _p++)
	{
		m_solid_object(player_get(_p), SOLID_TYPE.SIDES);
	}
}