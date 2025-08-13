for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	var _is_spinning = _player.animation == ANIM.SPIN;

	obj_act_solid(_player, SOLIDOBJECT.FULL, _is_spinning ? SOLIDATTACH.NONE : SOLIDATTACH.DEFAULT);

	if (!_is_spinning || !obj_check_solid(_player, SOLIDCOLLISION.TOP))
	{
		continue;
	}
	
	with (obj_player) 
	{
		if (on_object == other.id)
		{
			on_object = noone;
			is_grounded = false;
		}
	}
	
	_player.vel_y = -3;
	_player.add_score(++_player.score_combo);
	instance_create(x, y, obj_score, { vd_score_combo: _player.score_combo });
	
	for (var _i = 0; _i < 2; _i++)
	{
		for (var _j = 0; _j < 2; _j++)
		{
			var _vel_x = -2;
			var _vel_y = -2;

			if (_i > 0)
			{
				_vel_x *= -1;
			}

			if (_j > 0)
			{
				_vel_y = _vel_y * 0.5;
				_vel_x = _vel_x * 0.5;
			}

			instance_create(x - 8 + _i * 16, y - 8 + _j * 16, obj_piece,
			{
				vd_vel_x: _vel_x,
				vd_vel_y: _vel_y,
				vd_sprite: sprite_index,
				vd_x: 16 * _i,
				vd_y: 16 * _j,
				vd_width: 16,
				vd_height: 16
			});
		}
	}

	audio_play_sfx(snd_break_block);
	instance_destroy();

	break;
}