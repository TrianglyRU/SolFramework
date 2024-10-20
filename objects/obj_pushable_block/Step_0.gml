var _floor_dist;

switch (state)
{
	case PUSHABLEBLOCKSTATE.GROUND:
	
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			var _player = player_get(_p);
			
			direction_x = floor(_player.x) < floor(x) ? DIRECTION.POSITIVE : DIRECTION.NEGATIVE;
			
			obj_act_solid(_player, SOLIDOBJECT.FULL);
			
			if (_player.facing != direction_x || !obj_check_solid(_player, SOLIDCOLLISION.PUSH))
			{
				continue;
			}
			
			var _wall_dist = tile_find_h(x + (direction_x == DIRECTION.POSITIVE ? 15 : -16), y, direction_x, TILELAYER.MAIN)[0];
			
			if (_wall_dist <= 0)
			{
				continue;
			}
			
			var _push_force = 0.25;
			
			_player.spd_ground = _push_force * direction_x;
			_player.vel_x = 0;
			_player.x += direction_x;
			
			x += direction_x;
			
			if (!audio_is_playing(snd_push))
			{
				audio_play_sfx(snd_push);
			}
			
			if (vd_no_gravity)
			{
				continue;
			}
			
			_floor_dist = tile_find_v(x, y + 15, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
			
			if (_floor_dist <= 4)
			{
				y += _floor_dist;
				continue;
			}
			
			vel_x = 4 * direction_x;
			state = PUSHABLEBLOCKSTATE.LEDGE;
			
			obj_clear_solid_push(_player);
		}
		
	break;
	
	case PUSHABLEBLOCKSTATE.LEDGE:
	
		x += vel_x;
		
		if floor(x / vel_x) % vel_x == 0
		{
			x = round(x / solid_radius_x) * solid_radius_x; 
			state = PUSHABLEBLOCKSTATE.FALL;
		}
		
	break;
	
	case PUSHABLEBLOCKSTATE.FALL:
	
		y += vel_y;
		vel_y += 0.09375;
		
		_floor_dist = tile_find_v(x, y + 15, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
		
		if (_floor_dist < 0)
		{
			state = PUSHABLEBLOCKSTATE.GROUND;
			vel_y = 0;
			
			y += _floor_dist;
		}
		
	break;
}