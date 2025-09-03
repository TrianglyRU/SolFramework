mask_index = spr_buzz_bomber_hover;

// Inherit the parent event
event_inherited();

switch state
{
	case BUZZBOMBERSTATE.HOVER:
	
		if --state_timer < 0
		{
			state = BUZZBOMBERSTATE.ROAM;
			state_timer = 127;
			m_animation_start(spr_buzz_bomber_roam, 0, 0, 2);
		}
		
	break;
	
	case BUZZBOMBERSTATE.FIRE:
	
		if --state_timer < 0
		{
			projectile = instance_create(x - 29 * image_xscale_start, y + 28, obj_buzz_bomber_projectile, { image_xscale: image_xscale });
			state = BUZZBOMBERSTATE.HOVER;
			state_timer = 59;
			shot_flag = true;
			m_animation_start(spr_buzz_bomber_fire, 0, 0, 2);
		}
		
	break;
	
	case BUZZBOMBERSTATE.ROAM:
	
		if --state_timer < 0
		{
			state = BUZZBOMBERSTATE.HOVER;
			shot_flag = false;
			state_timer = 59;
			m_animation_start(spr_buzz_bomber_hover, 0, 0, 2);
			image_xscale *= -1;
			
			break;
		}
		
		x -= 4 * sign(image_xscale);
		
		if !shot_flag
		{
			var _player = player_get(obj_game.frame_counter % PLAYER_COUNT);
			var _dist_x = floor(x) - floor(_player.x);
			
			if _dist_x < 0
			{
				_dist_x *= -1;
			}
			
			if _dist_x >= 0 && _dist_x < 96 && instance_is_drawn()
			{
				state = BUZZBOMBERSTATE.FIRE;
				state_timer = 29;
				m_animation_start(spr_buzz_bomber_hover, 0, 0, 2);
			}
		}
		
	break;
}