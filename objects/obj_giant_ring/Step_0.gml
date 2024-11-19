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
            break;
        }
        
        obj_set_anim(spr_giant_ring_flash, 2, 0, 7);
        
		with (_player)
		{
			visible = false;
			state = PLAYERSTATE.LOCKED;
		}
        
        global.giant_ring_data =
        [
            x, y, obj_framework.frame_counter, obj_rm_stage.bound_upper[0], obj_rm_stage.bound_lower[0], obj_rm_stage.bound_left[0], obj_rm_stage.bound_right[0]
        ];
        
        state = GIANTRINGSTATE.ENTRY;
		
    break;
    
    case GIANTRINGSTATE.ENTRY:
        
        if (!obj_is_anim_ended())
        {
            break;
        }
        
        visible = false;
        
        if (--wait_timer == 0)
        {
            state = GIANTRINGSTATE.TRANSITION;
			
            audio_stop_bgm(0.5);
            audio_play_sfx(snd_warp);
			obj_set_culling(CULLING.NONE);
            fade_perform_white(FADEROUTINE.OUT, 1);
        }
        
    break;
    
    case GIANTRINGSTATE.TRANSITION:
    
        if (obj_framework.fade_state == FADESTATE.PLAINCOLOUR && !audio_is_playing(snd_warp))
        {
            room_goto(rm_special);
        }
   
	break;    
}