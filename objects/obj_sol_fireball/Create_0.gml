/// @method hurt_players()
hurt_players = function()
{
	for (var _p = 0; _p < PLAYER_COUNT; _p++)
	{
		var _player = player_get(_p);
		if (global.player_shields[_p] != SHIELD.FIRE && obj_check_hitbox(_player))
		{
			_player.hurt();
		}
	}
}

// Inherit the parent event
event_inherited();

obj_set_hitbox(4, 4);
obj_set_priority(4);

vel_x = 0;
flip_timer = 0;