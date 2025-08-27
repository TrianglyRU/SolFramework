switch (state)
{
    case GIANTRINGSTATE.IDLE:
        
        var _player = player_get(0);
		
        if (!obj_check_hitbox(_player))
        {
            break;
        }
        
        audio_play_sfx(snd_ring_giant);
        ds_list_add(global.ds_giant_rings, id);
        
        if (global.emerald_count >= 7)
        {
            global.player_rings = min(global.player_rings + 50, 999);
            instance_destroy();
        }
        else
		{
			_player.visible = false;
			_player.state = PLAYERSTATE.LOCKED;
		
	        obj_set_anim(spr_giant_ring_flash, 2, 0, 7);
        
	        global.giant_ring_data =
	        [
	            x, y, obj_game.frame_counter, obj_rm_stage.top_bound[0], obj_rm_stage.bottom_bound[0], obj_rm_stage.left_bound[0], obj_rm_stage.right_bound[0]
	        ];
        
	        state = GIANTRINGSTATE.ENTRY;
		}
		
    break;
	
    case GIANTRINGSTATE.ENTRY:
        
        if (!obj_is_anim_ended())
        {
            break;
        }
        
        visible = false;
		
        if (--wait_timer == 0)
        {
            state++;
			
            audio_stop_bgm(1.0);
            audio_play_sfx(snd_warp);
            fade_perform_white(FADE_DIRECTION.OUT, 1,, self.load_special_room);
        }
        
    break;  
}