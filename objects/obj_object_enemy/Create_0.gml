// Inherit the parent event
event_inherited();

/// @self obj_object_enemy
destroy = function(_player)
{
	_player.add_score(++_player.score_combo);
	
	with instance_create(x, y, obj_score)
	{
		combo = _player.score_combo;
	}
	
	instance_create(x, y, obj_animal);
	instance_create(x, y, obj_explosion_dust);
	audio_play_sfx(snd_destroy);
	instance_destroy();
}