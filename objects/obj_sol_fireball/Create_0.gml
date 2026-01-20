// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.NONE);

hurt_players = function()
{
	for (var _p = 0; _p < PLAYER_COUNT; _p++)
	{
		var _player = player_get(_p);
		
		if global.player_shields[_p] != SHIELD.FIRE && collision_player(_player)
		{
			_player.hurt();
		}
	}
}

depth = draw_depth(40);
vel_x = 0;
flip_timer = 0;