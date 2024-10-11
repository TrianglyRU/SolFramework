if (obj_is_anim_ended())
{
	obj_stop_anim(0);
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
		
	obj_act_solid(_player, SOLIDOBJECT.FULL, SOLIDATTACH.RESET_PLAYER);
	
	if (!obj_is_anim_stopped() || (floor(_player.x) - x + 4 * image_xscale) * image_xscale < 0)
	{
		continue;
	}
	
	var _collision_side = image_yscale >= 0 ? SOLIDCOLLISION.TOP : SOLIDCOLLISION.BOTTOM;
		
	if (!obj_check_solid(_player, _collision_side))
	{
		continue;
	}
	
	if (image_yscale >= 0)
	{
	    _player.animation = ANIM.BOUNCE;
	}
	
	with (_player)
	{
		if (other.image_yscale >= 0)
		{
			if (other.vd_flip_player)
			{
				animation = other.launch_force > 10 ? ANIM.FLIP_EXTENDED : ANIM.FLIP;
			}
			else
			{
				animation = ANIM.BOUNCE;
			}
		}
		
		y += other.image_yscale * 8;
		facing = other.image_xscale;
		vel_x = other.launch_force * other.image_xscale;
		vel_y = -other.launch_force * other.image_yscale;
		
		reset_state();
	}
	
	obj_set_anim(sprite_index, 1, [1, 1, 2, 2, 2, 2, 2, 2, 1], function(){ obj_stop_anim(0); });
	
	audio_play_sfx(snd_spring);
	input_set_rumble(_p, 0.20, INPUT_RUMBLE_MEDIUM);
}