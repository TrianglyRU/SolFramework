for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
	
    if (!obj_check_hitbox(_player))
    {
        continue;
    }
	
	audio_play_sfx(snd_bumper);
	obj_set_anim(sprite_index, 4, 1, stop_anim);
    
    if (hits_left != 0)
    {
		hits_left--;
		_player.m_add_score(0);
		
        instance_create(x, y, obj_score);
    }
    
	if (_player.action == ACTION.CARRIED)
	{
	    _player.action = ACTION.NONE;
	}
	
	var _angle = math_get_vector_rounded(_player.x - x, _player.y - y);
	  
	_player.is_jumping = false;
	_player.is_grounded = false;
	_player.air_lock_flag = false;
	_player.set_push_anim_by = noone;
	_player.vel_x = BUMPER_FORCE * dsin(_angle);
	_player.vel_y = BUMPER_FORCE * dcos(_angle);
}