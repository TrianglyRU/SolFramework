enum ENEMYTYPE
{
	BADNIK, BOSS
}

/// @function _destroy_badnik()
function _destroy_badnik(_player)
{
	gml_pragma("forceinline");
	
	_player.score_combo++;
	_player.add_score(_player.score_combo);
	
	instance_create(x, y, obj_score, { vd_score_combo: _player.score_combo });
	instance_create(x, y, obj_animal);
	instance_create(x, y, obj_explosion_dust);
	instance_destroy();
}

/// @self obj_game_object
/// @description Defines the behaviour and logic for an enemy object. Returns true if the enemy was not destroyed, false otherwise.
/// @param {Enum.ENEMYTYPE} [_type] The type of enemy (default is ENEMYTYPE.BADNIK)
/// @returns {Bool} 
function obj_act_enemy(_type = ENEMYTYPE.BADNIK)
{
	if (_type == ENEMYTYPE.BADNIK)
	{
		if (instance_exists(obj_water_flash) && y >= obj_rm_stage.water_level)
		{
			_destroy_badnik(player_get(0));
			return false;
		}
	}
	
	for (var _p = 0; _p < PLAYER_COUNT; _p++)
	{
		var _player = player_get(_p);
		var _action_check = false;
		var _tails_check = false;
		var _inv_check = false;
		
		if (!obj_check_hitbox(_player, true))
		{
			continue;
		}
		
		if (_player.is_true_glide() || _player.animation == ANIM.HAMMERDASH || _player.animation == ANIM.SPIN || _player.action == ACTION.SPINDASH)
		{
			_action_check = true;
		}
		
		if (_player.action == ACTION.FLIGHT)
		{
			var _vector = math_get_vector_rounded(_player.x - x, _player.y - y);
			if (math_get_quadrant(_vector) == QUADRANT.DOWN)
			{
				_tails_check = true;
			}
		}
		
		if (_player.super_timer > 0 || _player.item_inv_timer > 0)
		{
			_inv_check = true; 
		}
		
		if (!_action_check && !_tails_check && !_inv_check)
		{
			_player.hurt();
			continue;
		}
		
		if (_type == ENEMYTYPE.BOSS)
		{
			if (!_player.is_grounded)
			{
				_player.vel_x *= -0.5;
				_player.vel_y *= -0.5;
			}
			
			audio_play_sfx(snd_boss_hit);
			input_set_rumble(_player.player_index, 0.15, INPUT_RUMBLE_MEDIUM);	
			return false;
		}
		
		if (!_player.is_grounded)
		{
			if (floor(_player.y) >= floor(y) || _player.vel_y < 0)
			{
				_player.vel_y -= (_player.vel_y < 0 ? -1 : 1);
			}
			else if (_player.vel_y > 0)
			{
				_player.vel_y *= -1;
			}
		}
		
		_destroy_badnik(_player);
		input_set_rumble(_p, 0.05, INPUT_RUMBLE_LIGHT);
		
		return false;
	}
	
	return true;
}