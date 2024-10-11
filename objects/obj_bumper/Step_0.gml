for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
    
    if (!obj_check_hitbox(_player))
    {
        continue;
    }
    
	obj_set_anim(sprite_index, 4, [1, 0, 1], function(){ obj_stop_anim(0); });
    audio_play_sfx(snd_bumper);
    
    if (hits_left != 0)
    {
        hits_left--;
        _player.add_score(0);
		
        instance_create(x, y, obj_score);
    }
    
    var _angle = math_get_vector_rounded(_player.x - x, _player.y - y);
    
	with (_player)
	{
		if (action == ACTION.CARRIED)
	    {
	        action = ACTION.NONE;
	    }
	
		is_jumping = false;
	    is_grounded = false;
	    air_lock_flag = false;
	    set_push_anim_by = noone;
	    vel_x = BUMPER_FORCE * dsin(_angle);
	    vel_y = BUMPER_FORCE * dcos(_angle);
	}
}