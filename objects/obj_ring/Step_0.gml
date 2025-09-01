/// @feather ignore GM2016

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	if (global.ring_spill_counter >= 226)
	{
		continue;
	}
	
	var _player = player_get(_p);
	var _use_ext_hitbox = vd_state == RINGSTATE.DROP && (_player.shield_state == SHIELD_STATE.DOUBLE_SPIN || _player.action == ACTION.HAMMERSPIN);
	
	if (!obj_check_hitbox(_player, _use_ext_hitbox))
	{
		continue;
	}
	
	if (global.player_rings % 2 > 0)
	{
		audio_play_sfx(snd_ring_right);
	}
	else
	{
		audio_play_sfx(snd_ring_left);
	}
	
	if (global.player_rings < 999)
	{
		global.player_rings++;
	}
	
	instance_create(x, y, obj_sparkle);
	instance_destroy();
	return;
}

switch (vd_state)
{
	case RINGSTATE.STATIC:
	case RINGSTATE.ATTRACT:
	
		var _player = player_get(0);
		var _shield = global.player_shields[0];
		
		if (vd_state == RINGSTATE.STATIC)
		{
			if (_shield != SHIELD.LIGHTNING || distance_to_object(_player) > 64)
			{
				break;
			}
			
			vd_state = RINGSTATE.ATTRACT;
			obj_set_culling(ACTIVEIF.INBOUNDS_DELETE);
		}
		
		if (_shield == SHIELD.LIGHTNING)
		{
			var _acc_fast = 0.75;
			var _acc_slow = 0.1875;
		
			if (floor(x) >= floor(_player.x))
			{
				vd_vel_x = vd_vel_x >= 0 ? vd_vel_x - _acc_fast : vd_vel_x - _acc_slow;
			}
			else
			{
				vd_vel_x = vd_vel_x < 0 ? vd_vel_x + _acc_fast : vd_vel_x + _acc_slow;
			}
			
			if (floor(y) >= floor(_player.y))
			{
				vd_vel_y = vd_vel_y >= 0 ? vd_vel_y - _acc_fast : vd_vel_y - _acc_slow;
			}
			else
			{
				vd_vel_y = vd_vel_y < 0 ? vd_vel_y + _acc_fast : vd_vel_y + _acc_slow;
			}
		}
		
		x += vd_vel_x;
		y += vd_vel_y;
		
	break;
	
	case RINGSTATE.DROP:
		
		var _spill_timer = global.ring_spill_counter;
		if (_spill_timer == 0)
		{
			instance_destroy();
			break;
		}
		
		obj_set_anim(sprite_index, floor(512 / (_spill_timer)), 0, 0);
		
		x += vd_vel_x;
		y += vd_vel_y;
		vd_vel_y += 0.09375;
		
		if (vd_vel_y >= 0 && _spill_timer % 4 == 0)
		{
			var _floor_dist = tile_find_v(x, y + 8, 1)[0];
			if (_floor_dist < 0)
			{
				vd_vel_y *= -0.75;
				y += _floor_dist;
			}
		}
		
	break;
}