for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
   
	obj_act_solid(_player, SOLIDOBJECT.FULL, SOLIDATTACH.RESET_PLAYER);
	
    if (!obj_is_anim_stopped())
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
		if (vd_flip_player)
		{
			_player.animation = launch_force > 10 ? ANIM.FLIP_EXTENDED : ANIM.FLIP;
		}
		else
		{
			_player.animation = ANIM.BOUNCE;
		}
		
		with (_player)
		{
			obj_restart_anim();
		}
	}
	else
	{
		_player.vel_x = 0;
	}
	
	_player.y += image_yscale * 8;
	_player.vel_y = image_yscale * -launch_force;
	_player.m_reset_substate();
	
	obj_set_anim(sprite_index, 1, 1, stop_anim);
    audio_play_sfx(snd_spring);
	input_set_rumble(_p, 0.20, INPUT_RUMBLE_MEDIUM);
}