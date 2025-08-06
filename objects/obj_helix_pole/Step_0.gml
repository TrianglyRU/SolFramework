sprite_animate(obj_game.frame_counter, 12);
obj_set_hitbox(4, 16, -56 + 16 * image_index, 0);

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	if (obj_check_hitbox(_player))
	{
		_player.hurt();
	}
}