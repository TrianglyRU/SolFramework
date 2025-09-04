switch state
{
	case PUSH_BLOCK_STATE.GROUNDED:
	
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			var _player = player_get(_p);
			var _direction = sign(x - _player.x);
			
			m_solid_object(_player, SOLID_TYPE.FULL);
			
			if !solid_push[_p] || _player.facing != _direction
			{
				continue;
			}
			
			var _wall_dist = collision_tile_h(x + (_direction == 1 ? 15 : -16), y, _direction)[0];
			
			if _wall_dist <= 0
			{
				continue;
			}
			
			_player.spd_ground = 0.25 * _direction;
			_player.vel_x = 0;
			_player.x += _direction;
			
			x += _direction;
			
			if !audio_is_playing(snd_push)
			{
				audio_play_sfx(snd_push);
			}
			
			if !iv_no_gravity
			{
				var _floor_dist = collision_tile_v(x, y + 15, 1)[0];
				
				if _floor_dist <= 4
				{
					y += _floor_dist;
				}
				else
				{
					_player.m_clear_solid_push();
					
					vel_x = 4 * _direction;
					state = PUSH_BLOCK_STATE.ON_LEDGE;
				}
			}
		}
		
	break;
	
	case PUSH_BLOCK_STATE.ON_LEDGE:
	
		x += vel_x;	
		
		if floor(x / vel_x) % vel_x == 0
		{
			x = round(x / 16) * 16;
			state = PUSH_BLOCK_STATE.FALLING;
		}
		
	break;
	
	case PUSH_BLOCK_STATE.FALLING:
	
		y += vel_y;
		vel_y += 0.09375;
		
		var _floor_dist = collision_tile_v(x, y + 15, 1)[0];
		
		if _floor_dist < 0
		{
			y += _floor_dist;
			vel_y = 0;
			state = PUSH_BLOCK_STATE.GROUNDED;
		}
		
	break;
}