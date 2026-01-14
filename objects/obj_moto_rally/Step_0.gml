// Inherit the parent event
event_inherited();

switch state
{
    case MOTO_RALLY_STATE.MOVE:
    case MOTO_RALLY_STATE.MOVE_FAST:
	
		if animator.timer <= 0
		{
			animator.start(sprite_index, image_index, 0, 8);
		}
		
		x -= sign(image_xscale) * state;
		
		var _floor_dist = collision_tile_v(x - 8 * sign(image_xscale), y + 15, 1)[0];
		
		if _floor_dist >= 12 || _floor_dist < -8
		{
			animator.clear(image_index);
			state = MOTO_RALLY_STATE.IDLE;
		}
		else 
		{
			y += _floor_dist;
			
			if state != MOTO_RALLY_STATE.MOVE_FAST
			{
				var _player = player_get(obj_game.frame_counter % PLAYER_COUNT);
				var _dist_x = x - floor(_player.x);
			
			    if sign(_dist_x) == sign(image_xscale) && abs(_dist_x) < 64
			    {
			        animator.duration = 4;
			        state = MOTO_RALLY_STATE.MOVE_FAST;
			    }
			}
		}
		
    break;
	
	case MOTO_RALLY_STATE.IDLE:
	
		if ++state_timer == 30
		{
			state = MOTO_RALLY_STATE.MOVE;
			state_timer = 0;
			image_xscale *= -1;
		}
	
	break;
}