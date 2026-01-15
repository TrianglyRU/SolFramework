// Inherit the parent event
event_inherited();

blade_timer++;

switch state
{
    case HELIBOMBER_STATE.SEARCH:
		
		var _player = player_get(obj_game.frame_counter % PLAYER_COUNT);
		var _player_x = floor(_player.x);
		var _player_y = floor(_player.y);
		var _x = floor(x);
		var _y = floor(y);
		
		if abs(_x - _player_x) <= 128 && abs(_y - _player_y) <= 256
		{
			if _player_x > _x
			{
				dest_x = _player_x + 96;
				image_xscale = -1;
			}
			else
			{
				dest_x = _player_x - 96;
				image_xscale = 1;
			}
			
			player = _player;
			state = HELIBOMBER_STATE.FLY_TOWARDS;
		}
		
    break;

    case HELIBOMBER_STATE.FLY_TOWARDS:
		
        vel_x = (dest_x - x) / 32;
		
        if floor(dest_x / 8) == floor(x / 8)
        {
            state = HELIBOMBER_STATE.PREPARE;
            state_timer = 0;
        }
		
    break;

    case HELIBOMBER_STATE.PREPARE:
	
        if ++state_timer == 15
		{
			state = HELIBOMBER_STATE.SHOOT;
			image_index = 1;
		}
           
    break;

    case HELIBOMBER_STATE.SHOOT:
		
		if ++state_timer == 120
		{
			state = HELIBOMBER_STATE.SEARCH;
			player = noone;
			image_index = 0;
		}
        else if player != noone
		{
			if floor(x) < floor(player.x)
			{
				image_xscale = -1;
			}
			else
			{
				image_xscale = 1;
			}
			
			if state_timer == 90
			{
				with instance_create(floor(x) - 8 * sign(image_xscale), floor(y) + 18, obj_helibomber_projectile)
				{
					vel_x = (floor(other.player.x) - x) / 48;
					vel_y = (floor(other.player.y) - y) / 48;
					
					if vel_y < 0
					{
						vel_y *= -1;
					}
				}
			}
		}
        
    break;
}

var _new_y = math_oscillate_y(ystart, obj_game.frame_counter * 2.8125, 10);

x += vel_x;
y = _new_y;