switch (state)
{
    case FALLINGFLOORSTATE.IDLE:
        
        for (var _p = 0; _p < PLAYER_COUNT; _p++)
        {
            var _player = player_get(_p);
            obj_act_solid(_player, SOLIDOBJECT.TOP);
            
            if (!fall_flag)
            {
                fall_flag = obj_check_solid(_player, SOLIDCOLLISION.TOP);
            }
        }
        
        if (!fall_flag || wait_timer > 0)
        {
            if (fall_flag)
            {
                wait_timer--;
            }
            
            break;
        }
        
        var _is_flipped = image_xscale < 0;
        var _i = _is_flipped ? width - 16 : 0;  
		var _column = 0;
		var _row = 0;
		var _wait_timer = 0;
		
        while (true)
        {
            for (var _j = height - 16; _j >= 0; _j -= 16)
            {
				_wait_timer = _row * 2 + _column * 4;
				_row++;
				
                instance_create(corner_x + _i + 8, corner_y + _j + 8, obj_piece,
                {
                    vd_wait_time: _wait_timer,
                    vd_sprite: sprite_index,
                    vd_x: _is_flipped ? width - _i - 16 : _i,
                    vd_y: _j,
                    vd_width: 16,
                    vd_height: 16,
                    vd_flip_x: _is_flipped
                });
            }
            
            // Move to the next piece
            _i = _is_flipped ? _i - 16 : _i + 16;
			_column++;
			_row = 0;
            
            // Exit if it's out of bounds
            if (_i < 0 || _i >= width)
            {
                break;
            }
        }
        
        visible = false;
        state = FALLINGFLOORSTATE.FALL;
        wait_timer = _wait_timer;
        audio_play_sfx(snd_break_ledge);

    break;
    
    case FALLINGFLOORSTATE.FALL:
	
        for (var _p = 0; _p < PLAYER_COUNT; _p++)
        {
            obj_act_solid(player_get(_p), SOLIDOBJECT.TOP, SOLIDATTACH.NONE);
        }
        
        if (wait_timer > 0)
        {
            wait_timer--;
            break;
        }
        
        with (obj_player)
        {
			if (on_object == other.id)
			{
				is_grounded = false;
				on_object = noone;
			}
        }
        
        state++;
        
    break;
}