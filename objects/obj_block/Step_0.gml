for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	var _is_spinning = _player.animation == ANIM.SPIN;
	
	solid_object(_player, _is_spinning ? SOLID_TYPE.FULL_NO_LAND : SOLID_TYPE.FULL);
	
	if !_is_spinning || solid_touch[_p] != SOLID_TOUCH.TOP
	{
		continue;
	}
	
	with obj_player
	{
		if on_object == other.id
		{
			on_object = noone;
			is_grounded = false;
		}
	}
	
	_player.vel_y = -3;
	_player.add_score(++_player.score_combo);
	
	with instance_create(x, y, obj_score)
	{
		combo = _player.score_combo;
	}
	
	for (var _i = 0; _i < 2; _i++)
	{
		for (var _j = 0; _j < 2; _j++)
		{
			var _vel_x = -2;
			var _vel_y = -2;

			if _i > 0
			{
				_vel_x *= -1;
			}

			if _j > 0
			{
				_vel_y = _vel_y * 0.5;
				_vel_x = _vel_x * 0.5;
			}
			
			instance_create_piece(x - 8 + _i * 16, y - 8 + _j * 16, sprite_index, image_index, 16 * _i, 16 * _j, 16, 16, _vel_x, _vel_y, 0, false, false, false);
		}
	}

	audio_play_sfx(snd_break_block);
	instance_destroy();
	
	break;
}