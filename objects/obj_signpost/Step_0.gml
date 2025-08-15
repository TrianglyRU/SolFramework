switch (state)
{
	case SIGNPOSTSTATE.IDLE:
	
		var _player = player_get(0);
		var _dist = floor(_player.x) - x;
		
		if (_dist < 0 || _dist >= 32)
		{
			break;
		}
		
		with (obj_player)
		{
			if (player_index == 0 && super_timer > 0)
			{
				audio_play_bgm(obj_rm_stage.bgm_track);
			}
			
			super_timer = -1;
		}
		
		obj_gui_hud.update_timer = false;
		state = SIGNPOSTSTATE.ROTATE;
		player_object = _player;
		audio_play_sfx(snd_signpost);
		
	break;
	
	case SIGNPOSTSTATE.ROTATE:
	
		if (--sign_spin_timer < 0)
		{
			switch (++sign_spin_cycle)
			{
				case 1:
					obj_set_anim(sprite_index, 2, 1, 0);
				break;
				
				case 2:
					
					if (sprite_index != spr_signpost)
					{
						break;
					}
					
					var _sign_sprite;
					switch (player_object.vd_player_type)
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
						break;
					}
					
					obj_set_anim(_sign_sprite, 2, 0, 0);
					
				break;
				
				case 3:
					
					state = SIGNPOSTSTATE.MOVE_PLAYER;
					obj_stop_anim(0);
					
				break;
			}
			
			sign_spin_timer = 60;
		}
		
		if (--ring_sparkle_timer >= 0)
		{
			break;
		}
		
		var _off_x = ring_sparkle_pos[ring_sparkle_id];
		var _off_y = ring_sparkle_pos[ring_sparkle_id + 8];
		instance_create(x + _off_x, y + _off_y, obj_sparkle);
		
		if (++ring_sparkle_id > 7)
		{
			ring_sparkle_id = 0;
		}
		
		ring_sparkle_timer = 12;
		
	break;
	
	case SIGNPOSTSTATE.MOVE_PLAYER:
		
		if (player_object.state >= PLAYERSTATE.LOCKED)
		{
			break;
		}
		
		with (obj_player)
		{
			// This is what causes a player to keep their control during the act results screen
			/*if (!is_grounded)
			{
				break;
			}*/
			
			if (!input_no_control)
			{
				input_no_control = true;
				input_down = input_create();
				input_press = input_create();
				
				if (player_index == camera_data.index)
				{
					input_down.right = true;
				}
			}
				
			cpu_control_timer = 0;
		}
		
		if (floor(player_object.x) >= obj_rm_stage.end_bound - 24)
		{
			instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_results);		
			state++;
		}
		
	break;
}