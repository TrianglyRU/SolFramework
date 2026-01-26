// Feather ignore GM2016

switch state
{
	case PARACHUTE_STATE.IDLE:
	
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			var _player = player_get(_p);
			
			if !collision_player(_player)
			{
				continue;
			}
			
			player = _player;
			player.reset_substate();
			player.state = PLAYER_STATE.FROZEN;
			player.animation = ANIM.GRAB;
			player.vel_y = 0;
			player.spd = 0;
			
			if player.vel_x = 0
			{
				player.facing = sign(image_xscale);
			}
			else
			{
				player.facing = player.vel_x >= 0 ? 1 : -1;
			}
			
			state = PARACHUTE_STATE.CARRY_PLAYER;
			animator.start(sprite_index, 0, 0, 8);
			sync_with_player();
			
			audio_play_sfx(snd_grab);
			break;
		}
		
	break;
	
	case PARACHUTE_STATE.CARRY_PLAYER:
		
		if player.state != PLAYER_STATE.FROZEN
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
				if vel_x < -3
				{
					vel_x *= 0.8125;
				}
				
				if vel_x > 3
				{
					vel_x *= 0.8125;
					
					if vel_x < 3
					{
						vel_x = 3;
					}
				}
				else
				{
					vel_x += 0.0625;
					
					if vel_x > 3
					{
						vel_x = 3;
					}
				}
			}
			else
			{
				if vel_x > 3
				{
					vel_x *= 0.8125;
				}
				
				if vel_x < -3
				{
					vel_x *= 0.8125;
					
					if vel_x > -3
					{
						vel_x = -3;
					}
				}
				else
				{
					vel_x -= 0.0625;
					
					if vel_x < -3
					{
						vel_x = -3;
					}
				}
			}
			
			if vel_y < 1
			{
				vel_y += 0.125;
			}
			
			x += vel_x;
			y += vel_y;
			
			// Collide with the level
			scr_player_collision_air_regular();
			
			if input_press_action_any()
			{
				other.state = PARACHUTE_STATE.LEFTOVER;
				state = PLAYER_STATE.DEFAULT;
				animation = ANIM.SPIN;
				vel_y = -4;
				is_jumping = true;
				radius_x = radius_x_spin;
				radius_y = radius_y_spin;
				reset_gravity();
				
				audio_play_sfx(snd_jump);
			}
			else
			{
				other.sync_with_player();
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