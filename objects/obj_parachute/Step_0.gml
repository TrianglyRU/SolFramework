switch state
{
	case PARACHUTE_STATE.IDLE:
	
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			var _player = player_get(_p);
			
			if _player.action == ACTION.USE_OBJECT || !collision_player(_player)
			{
				continue;
			}
			
			player = _player;
			player.reset_substate();
			player.spd = player.vel_x;
			player.vel_y = 0;
			player.grv = 0;
			player.facing = player.vel_x >= 0 ? 1 : -1;
			player.action = ACTION.USE_OBJECT;
			player.animation = ANIM.GRAB;
			
			x = player.x;
			y = player.y - player.radius_y - 20;
			
			state = PARACHUTE_STATE.CARRY_PLAYER;
			animator.start(sprite_index, 0, 0, 8);
			
			audio_play_sfx(snd_grab);
			break;
		}
		
	break;
	
	case PARACHUTE_STATE.CARRY_PLAYER:
		
		if player.action != ACTION.USE_OBJECT
		{
			state = PARACHUTE_STATE.LEFTOVER;
		}
		else with player
		{
			if input_press.left
			{
				facing = -1;
			}
			
			if input_press.right
			{
				facing = 1;
			}
		
			if facing == 1
			{
				if spd < -3
				{
					spd *= 0.8125;
				}
				
				if spd > 3
				{
					spd *= 0.8125;
					if spd < 3
					{
						spd = 3;
					}
				}
				else
				{
					spd += 0.0625;
					if spd > 3
					{
						spd = 3;
					}
				}
			}
			else
			{
				if spd > 3
				{
					spd *= 0.8125;
				}
				
				if spd < -3
				{
					spd *= 0.8125;
					if spd > -3
					{
						spd = -3;
					}
				}
				else
				{
					spd -= 0.0625;
					if spd < -3
					{
						spd = -3;
					}
				}
			}
			
			if vel_y < 1
			{
				vel_y += 0.125;
			}
			
			vel_x = spd;
			
			x += vel_x;
			y += vel_y;
			
			other.x = x;
			other.y = y - radius_y - 20;
			other.vel_x = vel_x;
			other.vel_y = vel_y;
			
			if input_press_action_any()
			{
				action = ACTION.NONE;
				animation = ANIM.SPIN;
				vel_y = -4;
				is_jumping = true;
				radius_x = radius_x_spin;
				radius_y = radius_y_spin;
				reset_gravity();
			}
		}
		
	break;
	
	case PARACHUTE_STATE.LEFTOVER:
	
		if vel_y < 1
		{
			vel_y += 0.125;
		}
		
		x += vel_x;
		y += vel_y;
		
	break;
}