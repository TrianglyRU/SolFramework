// Inherit the parent event
event_inherited();

m_destroy = function(_player)
{
	_player.score_combo++;
	_player.m_add_score();
	
	instance_create(x, y, obj_score, { vd_score_combo: _player.score_combo });
	instance_create(x, y, obj_animal);
	instance_create(x, y, obj_explosion_dust);
	instance_destroy();
}