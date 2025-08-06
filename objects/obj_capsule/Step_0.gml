switch (state)
{
    case CAPSULESTATE.IDLE:
        
        if (button_obj.offset_y == 0)
        {
            break;
        }
        
        obj_set_culling(ACTIVEIF.OBJECTS_ACTIVE);
        instance_create(x, lock_obj.y, obj_explosion_dust);
		
        with (obj_player)
        {
            if (player_index == 0 && super_timer > 0)
            {
                audio_play_bgm(obj_rm_stage.bgm_track);
            }
            
            super_timer = -1;
        }
        
        with (lock_obj)
        {
			vel_x = 8;
			vel_y = -4;
            obj_set_culling(ACTIVEIF.INBOUNDS_DELETE);
        }
        
        state = CAPSULESTATE.BREAK;
        wait_timer = 29;
		obj_gui_hud.update_timer = false;
        
    break;
    
    case CAPSULESTATE.BREAK:
        
        if (--wait_timer >= 0)
        {
            break;
        }
        
        for (var _i = 0; _i < 8; _i++)
        {
            instance_create(x - 28 + 7 * _i, y, obj_animal, { vd_release_timer: 154 - _i * 8, vd_random_direction: true });
        }
        
        with (gate_obj)
        {
			obj_set_anim(sprite_index, 4, 0, function(){ instance_destroy(); });
        }
        
        state = CAPSULESTATE.SPAWN_ANIMALS;
        wait_timer = 180;
		
    break;
      
    case CAPSULESTATE.SPAWN_ANIMALS:
        
        if (obj_game.frame_counter % 8 == 0)
        {
			instance_create(x + irandom_range(-25, 25), y, obj_animal, { vd_release_timer: 12, vd_random_direction: true });
        }
        else if (--wait_timer == 0)
        {
            state = CAPSULESTATE.WAIT_ANIMALS;
        }
        
    break;
    
    case CAPSULESTATE.WAIT_ANIMALS:
		
		var _start_results = false;
		with (obj_animal)
		{
			_start_results = !obj_is_visible();
			if (!_start_results)
			{
				break;
			}
		}
		
        if (_start_results)
        {
            instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_results);
            audio_play_bgm(snd_bgm_actclear);
            state++;
        }
        
        break;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    obj_act_solid(player_get(_p), SOLIDOBJECT.FULL);
}