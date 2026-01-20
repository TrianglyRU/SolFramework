instance_animate(obj_game.frame_counter, 12);

// Offset the hitbox each animation frame
offset_x = 16 * image_index;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if collision_player(_player,, bbox_left + offset_x,, bbox_right + offset_x,)
	{
		_player.hurt();
	}
}