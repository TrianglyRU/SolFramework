/// @function _start_respawn()
function _start_respawn()
{
	gml_pragma("forceinline");
	
	if (obj_is_visible() || x >= camera_data.right_bound)
	{
	    cpu_timer_respawn = 0;
	    return false;
	}
	
	if (++cpu_timer_respawn >= 300 || on_object != noone && !instance_exists(on_object))
	{
	    self.respawn();
	    return true;
	}

	return false;
}

/// @self obj_player
/// @feather ignore GM2044
/// @function scr_player_cpu()
function scr_player_cpu()
{
	gml_pragma("forceinline");

	if (player_index == 0)
	{
	    return;
	}
	
	var _jump_freq = 64;
	var _cpu_behaviour = global.cpu_behaviour;
	var _delay = PARAM_CPU_DELAY * player_index;
	
	cpu_target = player_get(0);
	
	var _can_receive_input = player_index < INPUT_SLOT_COUNT;
	if (_can_receive_input)
	{
	    if (input_down.action_any || input_down.up || input_down.down || input_down.left || input_down.right)
	    {
	        cpu_control_timer = 600;
	    }
	}

	switch (cpu_state)
	{
	    case CPUSTATE.RESPAWN_INIT:
			
	        if (_can_receive_input && !input_down.action_any && !input_down.start)
	        {
				if (obj_game.frame_counter % 64 != 0 || cpu_target.state >= PLAYERSTATE.LOCKED)
				{
					break;
				}
	        }
			
	        x = cpu_target.x;
	        y = cpu_target.y - camera_get_height(cpu_target.camera_data.index) + 32;
			visible = true;
	        cpu_state = CPUSTATE.RESPAWN;
			
			if (camera_data.index == player_index)
			{
				camera_data.allow_movement = true;
			}
			
	    break;

	    case CPUSTATE.RESPAWN:
		
	        if (_start_respawn())
	        {
	            break;
	        }

	        switch (vd_player_type)
	        {
	            case PLAYER.SONIC:
	            case PLAYER.AMY:
	                animation = ANIM.SPIN;
	            break;
				
	            case PLAYER.TAILS:
				
	                animation = is_underwater ? ANIM.SWIM : ANIM.FLY;
	                self.play_tails_sound();
					
	            break;

	            case PLAYER.KNUCKLES:
	                animation = ANIM.GLIDE_AIR;
	            break;
	        }
			
	        var _follow_data = cpu_target.ds_record_data[| _delay];
	        var _target_x = _follow_data[2];
	        var _target_y = _follow_data[3];
			
	        if (_cpu_behaviour == CPUBEHAVIOUR.S2 && instance_exists(obj_rm_stage) && obj_rm_stage.water_enabled)
	        {
	            _target_y = min(obj_rm_stage.water_level - 16, _target_y);
	        }
			
	        var _dist_x = floor(x) - _target_x;
	        if (_dist_x != 0)
	        {
	            var _vel_x = abs(cpu_target.vel_x) + min(floor(abs(_dist_x) / 16), 12) + 1;
	            if (_dist_x >= 0)
	            {
	                if (_vel_x < _dist_x)
	                {
	                    _vel_x *= -1;
	                }
	                else
	                {
	                    _vel_x = -_dist_x;
	                    _dist_x = 0;
	                }
					
	                facing = DIRECTION.NEGATIVE;
	            }
	            else
	            {
	                _dist_x *= -1;
	                if (_vel_x >= _dist_x)
	                {
	                    _vel_x = _dist_x;
	                    _dist_x = 0;
	                }
					
	                facing = DIRECTION.POSITIVE;
	            }
				
	            x += _vel_x;
	        }
			
	        var _dist_y = floor(y) - _target_y;
	        if (_dist_y != 0)
	        {
	            y -= sign(_dist_y);
	        }
			  
	        if (_cpu_behaviour == CPUBEHAVIOUR.S3 && (obj_game.state != GAMESTATE.NORMAL || cpu_target.state == PLAYERSTATE.DEATH))
	        {
	            break;
	        }
			
	        if (_dist_x == 0 && _dist_y == 0)
	        {
	            cpu_state = CPUSTATE.MAIN;
	            animation = ANIM.MOVE;
	            state = PLAYERSTATE.DEFAULT;
				secondary_layer = cpu_target.secondary_layer;
	        }
			
	    break;

	    case CPUSTATE.MAIN:
			
			depth = cpu_target.depth + player_index;
			
	        if (cpu_target.state == PLAYERSTATE.DEATH)
	        {
	            state = PLAYERSTATE.LOCKED;
	            cpu_state = CPUSTATE.RESPAWN;
	            self.reset_substate();
				
	            break;
	        }
			
	        if (_start_respawn())
	        {
	            break;
	        }

	        if (carry_target != noone || action == ACTION.CARRIED || state >= PLAYERSTATE.LOCKED)
	        {
	            break;
	        }
			
	        if (cpu_control_timer > 0)
	        {
	            cpu_control_timer--;
	            if (!input_no_control)
	            {
	                break;
	            }
	        }
			
	        var _follow_data = cpu_target.ds_record_data[| _delay];
	        var _target_input_press = input_copy(_follow_data[0]);
	        var _target_input_down = input_copy(_follow_data[1]);
	        var _target_x = _follow_data[2];
	        var _target_y = _follow_data[3];
	        var _target_push_flag = _follow_data[4];
	        var _target_facing = _follow_data[5];
			
	        if (ground_lock_timer != 0 && spd_ground == 0)
	        {
	            cpu_state = CPUSTATE.STUCK;
	        }
			
	        if (_cpu_behaviour == CPUBEHAVIOUR.S3 && abs(cpu_target.spd_ground) < 4 && cpu_target.on_object == noone)
	        {
	            _target_x -= 32;
	        }
			
	        var _do_jump = true;
			
	        if (set_push_anim_by == noone || _target_push_flag != noone)
	        {   
	            var _dist_x = _target_x - floor(x);
	            if (_dist_x != 0)
	            {
	                var _max_dist_x = _cpu_behaviour == CPUBEHAVIOUR.S3 ? 48 : 16;
	                if (_dist_x > 0)
	                {
	                    if _dist_x > _max_dist_x
	                    {
	                        _target_input_down.left = false;
	                        _target_input_press.left = false;
	                        _target_input_down.right = true;
	                        _target_input_press.right = true;
	                    }
	                }
	                else if (_dist_x < -_max_dist_x)
	                {
	                    _target_input_down.left = true;
	                    _target_input_press.left = true;
	                    _target_input_down.right = false;
	                    _target_input_press.right = false;
	                }
					
	                var _dist_sign = sign(_dist_x);
					
	                if (spd_ground != 0 && sign(facing) == _dist_sign)
	                {
	                    x += _dist_sign;
	                }
	            }
	            else
	            {
	                facing = _target_facing;
	            }

	            if (!cpu_jump_flag)
	            {	
	                if (_dist_x >= 64 && obj_game.frame_counter % (_jump_freq * 4) != 0 || _target_y - floor(y) > -32)
	                {
	                    _do_jump = false;  
	                }
	            }
	            else
	            {
	                _target_input_down.action_any = true;
					
	                if (is_grounded)
	                {
	                    cpu_jump_flag = false;
	                }
	                else
	                {
	                    _do_jump = false;
	                }
	            }
	        }
			
	        if (_do_jump && obj_game.frame_counter % _jump_freq == 0 && animation != ANIM.DUCK && cpu_target.animation != ANIM.WAIT)
	        {
	            _target_input_press.action_any = true;
	            _target_input_down.action_any = true;
				
	            cpu_jump_flag = true;
	        }
			
	        input_press = _target_input_press;
	        input_down = _target_input_down;
			
	    break;

	    case CPUSTATE.STUCK:
		
	        if (_start_respawn())
	        {
	            break;
	        }

	        if (ground_lock_timer != 0 || cpu_control_timer != 0 || spd_ground != 0)
	        {
	            break;
	        }

	        if (animation == ANIM.IDLE)
	        {
	            if floor(cpu_target.x) >= floor(x)
	            {
	                facing = DIRECTION.POSITIVE;
	            }
	            else
	            {
	                facing = DIRECTION.NEGATIVE;
	            }
	        }

	        input_down.down = true;
			
			if (obj_game.frame_counter % 128 == 0)
			{
				input_down.down = false;
				input_press.action_any = false;
				cpu_state = CPUSTATE.MAIN;
			}
			else if (obj_game.frame_counter % 32 == 0)
			{
				input_press.action_any = true;
			}
			
	    break;  
	}
}