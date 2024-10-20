if (!obj_act_enemy())
{
	return;
}
	
switch (state)
{
	case COCONUTSSTATE.IDLE:
		
		var _player = instance_nearest(x, y, obj_player);
		var _dist_x = floor(x) - floor(_player.x);
		var _total_dist_x = _dist_x + 96;
		
		image_xscale = sign(_dist_x);
		
		if (_total_dist_x >= 0 && _total_dist_x < 192)
		{
			if (attack_timer == 0)
			{
				state = COCONUTSSTATE.START_THROW;
				break;
			}
				
			attack_timer--;
		}
			
		if (--state_timer < 0)
		{
			state_timer = COCONUTSSTATE.START_CLIMB;
		}
			
	break;
		
	case COCONUTSSTATE.START_CLIMB:
		
		state = COCONUTSSTATE.CLIMB;
			
		if (climb_table_index >= 12)
		{
			climb_table_index = 0;
		}
		
		vel_y = climb_data[climb_table_index];
		state_timer = climb_data[climb_table_index + 1];		
		climb_table_index += 2;
		
		obj_set_anim(sprite_index, 6);
		
	break;
	
	case COCONUTSSTATE.CLIMB:
			
		if (--state_timer == 0)
		{
			state = COCONUTSSTATE.IDLE;
			state_timer = 16;
			
			obj_stop_anim(0);
			break;
		}
			
		hand_frame = image_index;
		y += vel_y;
			
	break;
		
	case COCONUTSSTATE.START_THROW:
		
		state = COCONUTSSTATE.THROW;
		state_timer = 8;
		attack_timer = 32;	
		hand_frame = 2;
		
	break;
		
	case COCONUTSSTATE.THROW:
			
		if (--state_timer >= 0)
		{
			break;
		}
		
		if (!attack_flag)
		{
			attack_flag = true;
			state_timer = 8;
			hand_frame = image_index;
			
			instance_create(x + 11 * image_xscale, y - 13, obj_coconuts_projectile, { image_xscale: image_xscale });
			break;
		}
			
		state = COCONUTSSTATE.START_CLIMB;
		attack_flag = false;
			
	break;
}