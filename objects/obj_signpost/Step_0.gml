switch state
{
	case SIGNPOST_STATE.IDLE:
	
		var _player = player_get(0);
		var _dist = floor(_player.x) - x;
		
		if _dist < 0 || _dist >= 32
		{
			break;
		}
		
		if _player.super_timer > 0 && instance_exists(obj_rm_stage)
		{
			audio_play_bgm(obj_rm_stage.bgm_track);
		}
		
		with obj_player
		{
			super_timer = -1;
		}
		
		obj_gui_hud.update_timer = false;
		
		state = SIGNPOST_STATE.ROTATE;
		player = _player;
		
		audio_play_sfx(snd_signpost);
		
	break;
	
	case SIGNPOST_STATE.ROTATE:
	
		if --sign_spin_timer < 0
		{
			sign_spin_timer = 60;
			
			switch ++sign_spin_cycle
			{
				case 1:
				
					if animator.timer == 0
					{
						animator.start(sprite_index, 1, 0, 2);
					}
					
				break;
				
				case 2:
					
					if sprite_index != spr_signpost
					{
						break;
					}
					
					var _sign_sprite;
					
					switch player.player_type
					{
						case PLAYER.TAILS:
							_sign_sprite = spr_signpost_tails;
						break;
						
						case PLAYER.KNUCKLES:
							_sign_sprite = spr_signpost_knuckles;
						break;
						
						case PLAYER.AMY:
							_sign_sprite = spr_signpost_amy;
						break;
						
						default:
							_sign_sprite = spr_signpost_sonic;
					}
					
					animator.start(_sign_sprite, 0, 0, 2);
					
				break;
				
				case 3:
					
					state = SIGNPOST_STATE.CONTROL_PLAYER;
					animator.clear(0);
					
				break;
			}
		}
		
		if --ring_sparkle_timer < 0
		{
			var _off_x = ring_sparkle_pos[ring_sparkle_id];
			var _off_y = ring_sparkle_pos[ring_sparkle_id + 8];
		
			instance_create(x + _off_x, y + _off_y, obj_sparkle);
			
			if ++ring_sparkle_id > 7
			{
				ring_sparkle_id = 0;
			}
			
			ring_sparkle_timer = 12;
		}
		
	break;
	
	case SIGNPOST_STATE.CONTROL_PLAYER:
		
		var _transition_exists = instance_exists(obj_transition_save);
		var _results_exist = instance_exists(obj_gui_results);
		
		var _is_grounded = player.is_grounded;
		var _reached_end = player.x >= obj_rm_stage.end_bound - 24;

		with obj_player
		{
		    if state >= PLAYER_STATE.DEBUG_MODE
			{
				continue;
			}
    
		    if !input_no_control
			{
		        var _should_take_control = false;
        
		        if !_transition_exists
				{
		            _should_take_control = true;
		        }
				else if _is_grounded
				{
		            _should_take_control = true;
		        }
        
		        if _should_take_control
				{
		            input_no_control = true;
		            input_down = input_create();
		            input_press = input_create();
					
		            if !_transition_exists && player_index == 0
					{
		                input_down.right = true;
		            }
		        }
		    }
			else if _transition_exists
			{
		        state = PLAYER_STATE.DEFAULT_LOCKED;
				animation = ANIM.ACT_CLEAR;
		    }
			
		    cpu_control_timer = 0;
		}
		
		if !_results_exist
		{
		    if !_transition_exists && _reached_end || _transition_exists && _is_grounded
			{
		        instance_create(0, 0, obj_gui_results);
		    }
		}
		
	break;
}