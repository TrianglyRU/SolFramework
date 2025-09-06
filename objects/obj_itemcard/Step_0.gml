switch state
{
    case ITECARD_STATE.MOVE:
    
        if vel_y >= 0
        {
			state = ITECARD_STATE.IDLE;
	        wait_timer = 29;
			
	        var _player = player_get(0);
	        var _player_shield = global.player_shields[0];
        
	        switch image_index
	        {
	            // Nothing
	            case 0: break;
			
	            // Eggman Mark
	            case 1:
	               _player.hurt();
	            break;
			
	            // Super Ring
	            case 2:
			
	                global.player_rings = min(global.player_rings + 10, 999);
				
	                audio_play_sfx(snd_ring_left);
	                audio_play_sfx(snd_ring_right);
				
	            break; 
			
	            // Power Sneakers
	            case 3:
			
	                if _player.super_timer <= 0
	                {
	                    audio_play_bgm(snd_bgm_highspeed);
	                }
				
	                _player.item_speed_timer = 1200;
				
	            break; 
			
	            // Normal Shield
	            case 4:
				
					global.player_shields[0] = SHIELD.NORMAL;
					audio_play_sfx(snd_shield);
					
	            break;
				
				// Bubble Shield
	            case 5:
				
					if audio_is_playing(snd_bgm_drowning)
	                {
						_player.restart_bgm();
	                }
					
					global.player_shields[0] = SHIELD.BUBBLE;
					audio_play_sfx(snd_shield_bubble);
				
	            break; 
				
				// Fire Shield
	            case 6:
				
					global.player_shields[0] = SHIELD.FIRE;
					audio_play_sfx(snd_shield_fire);
					
	            break;
				
				// Lightning Shield
	            case 7:
				
	                global.player_shields[0] = SHIELD.LIGHTNING;
					audio_play_sfx(snd_shield_lightning); 
					
	            break;
			
	            // Invincibility
	            case 8:
			
	                if _player.super_timer > 0
	                {
	                    break;
	                }
                
	                if _player.item_inv_timer == 0
	                {
	                    for (var _i = 0; _i < 8; _i++)
	                    {
	                        with instance_create(x, y, obj_star_invincibility)
							{
								player = _player.id;
								star_index = _i;
							}
	                    }
					
	                    audio_play_bgm(snd_bgm_invincibility);
	                }
				
	                _player.item_inv_timer = 1200;
				
	            break;
			
	            // 1-UP
	            default:
					
	                global.life_count++;
	                audio_play_bgm(snd_bgm_extralife, AUDIO_CHANNEL_JINGLE);
				
	            break;
	        }
        
	        if global.player_shields[0] != _player_shield
	        {
	            with obj_shield
	            {
					if player == _player
					{
						instance_destroy();
					}
	            }
				
	            instance_create(0, 0, obj_shield, { player: _player });
	        }
        }
		else
		{
			y += vel_y;
			vel_y += 0.09375;
		}
		
    break;
    
    case ITECARD_STATE.IDLE:
    
        if --wait_timer == 0
        {
            instance_destroy();
        }
		
    break;
}