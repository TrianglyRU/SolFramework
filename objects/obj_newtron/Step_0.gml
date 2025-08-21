var _floor_dist;

switch (state)
{
	case NEWTRONSTATE.FIND_TARGET:
		
		var _player = player_get(obj_game.frame_counter % PLAYER_COUNT);
		var _dist_x = floor(_player.x) - x;
		
		if (abs(_dist_x) >= 128)
		{
			break;
		}
		
		if (vd_type == NEWTRONTYPE.FIRE)
		{
			state = NEWTRONSTATE.FIRE;
 			obj_set_anim(image_index == 0 ? spr_newtron_fire_blue : spr_newtron_fire_green, 20, 0, function()
			{
				instance_destroy();
			});
		}
		else
		{
			state = NEWTRONSTATE.FALL;
			obj_set_anim(image_index == 0 ? spr_newtron_fall_blue : spr_newtron_fall_green, 20, 0, 4);
		}
		
		visible = true;
		image_xscale = _dist_x < 0 ? 1 : -1;
		target_player = _player;
	
	break;
	
	case NEWTRONSTATE.FIRE:
		
		if (image_index == 3 && !shot_flag)
		{
			shot_flag = true;
			instance_create(x - 20 * image_xscale, y - 8, obj_newtron_projectile, { image_xscale: image_xscale });
		}
		else if (image_index > 0)
		{
			obj_act_enemy();
		}
	
	break;
	
	case NEWTRONSTATE.FALL:
		
		if (image_index < 3)
		{
			image_xscale = floor(target_player.x) - x < 0 ? 1 : -1;
			break;
		}
		
		y += vel_y;
		vel_y += 0.21875;
		
		_floor_dist = tile_find_v(x, y + 16, DIRECTION.POSITIVE)[0];
		if (_floor_dist < 0)
		{
			y += _floor_dist;
			state = NEWTRONSTATE.FLOOR;
			vel_y = 0;
			obj_set_hitbox(20, 8);
			obj_set_anim(sprite_index == spr_newtron_fall_blue ? spr_newtron_fly_blue : spr_newtron_fly_green, 3, 0, 0);
		}
	
	break;
	
	case NEWTRONSTATE.FLOOR:
	case NEWTRONSTATE.FLY:
		
		if (!obj_act_enemy())
		{
			return;
		}
		
		x -= 2 * sign(image_xscale);
		
		if (state == NEWTRONSTATE.FLOOR)
		{
			_floor_dist = tile_find_v(x, y + 16, DIRECTION.POSITIVE)[0];
			if (_floor_dist < -8 || _floor_dist >= 12)
			{
				state = NEWTRONSTATE.FLY;
			}
			else
			{
				y += _floor_dist;
			}
		}
		
	break;
}