if (!obj_act_enemy())
{
	return;
}

var _floor_dist;

switch (state)
{
	case MOTOBUGSTATE.INIT:
	
		y += vel_y;
		vel_y += 0.21875;
		
		_floor_dist = tile_find_v(x, y + 14, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
		
		if (_floor_dist < 0)
		{
			y += _floor_dist;
			vel_y = 0;
			state = MOTOBUGSTATE.WAIT;
			image_xscale *= -1;
		}
		
	break;
	
	case MOTOBUGSTATE.WAIT:
	
		if (--move_timer < 0)
		{
			state = MOTOBUGSTATE.ROAM;
			vel_x = sign(image_xscale);
			image_xscale *= -1;
			visible = true;
			
			obj_set_anim(sprite_index, 8, 0, 0);
		}
		
	break;
	
	case MOTOBUGSTATE.ROAM:
	
		x += vel_x;
		
		_floor_dist = tile_find_v(x, y + 14, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
		
		if (_floor_dist > 11 || _floor_dist < -8)
		{
			state = MOTOBUGSTATE.WAIT;
			move_timer = 59;
			vel_x *= -1;
			
			obj_stop_anim(0);
			break;
		}
		
		y += _floor_dist;
		
		if (--smoke_timer < 0)
		{
			smoke_timer = 15;
			instance_create(x + 19 * image_xscale, y, obj_moto_bug_smoke);
		}
		
	break;
}