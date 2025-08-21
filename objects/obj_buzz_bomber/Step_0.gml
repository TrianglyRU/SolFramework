if (!obj_act_enemy())
{
	return;
}

switch (state)
{
	case BUZZBOMBERSTATE.HOVER:
	
		if (--state_timer < 0)
		{
			state = BUZZBOMBERSTATE.ROAM;
			state_timer = 127;
			
			obj_set_anim(spr_buzz_bomber_roam, 2, 0, 0);
		}
		
	break;
	
	case BUZZBOMBERSTATE.FIRE:
	
		if (--state_timer < 0)
		{
			state = BUZZBOMBERSTATE.HOVER;
			state_timer = 59;
			shot_flag = true;
			
			instance_create_child(x - 29 * image_xscale, y + 28, obj_buzz_bomber_projectile, { image_xscale: image_xscale });
			obj_set_anim(spr_buzz_bomber_fire, 2, 0, 0);
		}
		
	break;
	
	case BUZZBOMBERSTATE.ROAM:
	
		if (--state_timer < 0)
		{
			state = BUZZBOMBERSTATE.HOVER;
			shot_flag = false;
			state_timer = 59;
			image_xscale *= -1;
			
			obj_set_anim(spr_buzz_bomber_hover, 2, 0, 0);
			break;
		}
		
		x -= 4 * sign(image_xscale);
		
		if (shot_flag)
		{
			break;
		}
		
		var _player = player_get(obj_game.frame_counter % PLAYER_COUNT);
	    var _dist_x = x - floor(_player.x);
		
		if (_dist_x < 0)
		{
			_dist_x *= -1;
		}
		
		if (_dist_x >= 0 && _dist_x < 96 && obj_is_visible())
		{
			state = BUZZBOMBERSTATE.FIRE;
			state_timer = 29;
			
			obj_set_anim(spr_buzz_bomber_hover, 2, 0, 0);
		}
		
	break;
}