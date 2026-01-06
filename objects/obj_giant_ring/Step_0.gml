switch state
{
    case GIANT_RING_STATE.IDLE:
        
        var _player = player_get(0);
		
        if !collision_player(_player)
		{
			break;
		}
        
        audio_play_sfx(snd_ring_giant);
        ds_list_add(global.ds_giant_rings, id);
        
        if global.emerald_count >= 7
        {
			instance_destroy();
            global.player_rings = min(global.player_rings + 50, 999);  
        }
        else
		{
			_player.visible = false;
			_player.state = PLAYER_STATE.DEFAULT_LOCKED;
			
			animator.start(spr_giant_ring_flash, 0, 7, 2);
			
	        global.giant_ring_data =
	        [
	            x, y, obj_game.frame_counter, obj_rm_stage.top_bound[0], obj_rm_stage.bottom_bound[0], obj_rm_stage.left_bound[0], obj_rm_stage.right_bound[0]
	        ];
        
	        state = GIANT_RING_STATE.ENTRY;
		}
		
    break;
	
    case GIANT_RING_STATE.ENTRY:
        
        if animator.timer >= 0
		{
			break;
		}
        
        visible = false;
		
        if --wait_timer == 0
        {
            audio_stop_bgm(1);
            audio_play_sfx(snd_warp);
			
            fade_perform_white(FADE_DIRECTION.OUT, 1, function()
			{
				if !audio_is_playing(snd_warp)
				{
					room_goto(rm_special);
					return true;
				}
			});
        }
        
    break;
}