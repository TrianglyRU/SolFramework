visible = global.debug_collision > 0;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	if (_p == 0)
	{
		visible |= _player.state == PLAYERSTATE.DEBUG_MODE;
	}
	
	obj_act_solid(_player, SOLIDOBJECT.FULL);
}