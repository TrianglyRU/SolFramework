if (vd_is_decorative)
{
	return;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	obj_act_solid(player_get(_p), SOLIDOBJECT.SIDES, SOLIDATTACH.NONE);
}