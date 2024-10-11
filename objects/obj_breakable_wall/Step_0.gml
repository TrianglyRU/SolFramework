for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	var _smash_vel = _player.vel_x;
	
	obj_act_solid(_player, SOLIDOBJECT.SIDES);

	if (vd_knuckles_only && _player.vd_player_type != PLAYER.KNUCKLES)
	{
		continue;
	}
	
	if not (_player.animation == ANIM.SPIN && _player.is_grounded && abs(_smash_vel) >= 4
	  || _player.vd_player_type == PLAYER.KNUCKLES
	  || _player.action == ACTION.HAMMERSPIN
	  || _player.animation == ANIM.HAMMERDASH
	  || _player.shield == SHIELD.FIRE && _player.shield_state == SHIELDSTATE.ACTIVE
	  || _player.super_timer > 0)
	{
		continue;
	}
	
	var _side = floor(_player.x) < floor(x) ? SOLIDCOLLISION.LEFT : SOLIDCOLLISION.RIGHT;

	if (!obj_check_solid(_player, _side))
	{
		continue;
	}
	
	with (_player)
	{
		x -= 4 * sign(_smash_vel);
		vel_x = _smash_vel;
		spd_ground = vel_x;
		set_push_anim_by = noone;
	}

	var _smash_dir = floor(_player.x) >= floor(x) ? 1 : -1;

	for (var _i = 0; _i < 2; _i ++)
	{
		for (var _j = 0; _j < 4; _j++)
		{
			var _vel_x = 6 * _smash_dir;
			var _vel_y = -6 + 4 * _j;

			if (_smash_dir == -1 && _i == 1 || _smash_dir == 1 && _i == 0)
			{
				_vel_x -= 2 * sign(_vel_x);
				_vel_y -= 1 * sign(_vel_y);
			}

			instance_create(x - 8 + 16 * _i, y - 24 + 16 * _j, obj_piece,
			{
				vd_vel_x: _vel_x,
				vd_vel_y: _vel_y,
				vd_sprite: sprite_index,
				vd_frame_index: image_index,
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