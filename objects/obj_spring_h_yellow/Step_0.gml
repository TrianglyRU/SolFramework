for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
		
	obj_act_solid(_player, SOLIDOBJECT.FULL);
	
	if (!obj_is_anim_stopped() || !_player.is_grounded)
	{
		continue;
	}
		
	var _collision_side = image_xscale >= 0 ? SOLIDCOLLISION.RIGHT : SOLIDCOLLISION.LEFT;
		
	if (!obj_check_solid(_player, _collision_side))
	{
		if (sign(_player.vel_x) != sign(image_xscale) && _player.vel_x != 0)
		{
			continue;
		}
		
		var _y = floor(_player.y);
		
		if (_y < y - 24 || _y >= y + 24)
		{
			continue;
		}
		
		var _l_bound = x;
		var _r_bound = x + 40;
				
		if (image_xscale < 0)
		{
			_l_bound = x - 40;
			_r_bound = x;
		}
		
		var _x = floor(_player.x);
		
		if (_x < _l_bound || _x >= _r_bound)
		{
			continue;
		}
	}
	
	with (_player)
	{
		x -= other.image_xscale * 8;
		facing = other.image_xscale;
		vel_x = other.image_xscale * other.launch_force;
		spd_ground = vel_x;
		ground_lock_timer = 16;
		action = ACTION.NONE;
	}
	
	obj_set_anim(sprite_index, 1, [1, 1, 2, 2, 2, 2, 2, 2, 1], function(){ obj_stop_anim(0); });
	
	audio_play_sfx(snd_spring);
	input_set_rumble(_p, 0.20, INPUT_RUMBLE_MEDIUM);
}