switch state
{
    case CAPSULE_STATE.IDLE:
        
        if button_obj.offset_y != 0
        {
            instance_create(x, lock_obj.y, obj_explosion_dust);
			audio_play_sfx(snd_destroy);
			
	        with obj_player
	        {
	            if player_index == 0 && super_timer > 0
	            {
	                audio_play_bgm(obj_rm_stage.bgm_track);
	            }
            
	            super_timer = -1;
	        }
			
			lock_obj.vel_x = 8;
			lock_obj.vel_y = -4;
			lock_obj.culler.action = CULL_ACTION.DESTROY;
	        state = CAPSULE_STATE.BREAK;
	        wait_timer = 29;
		
			obj_gui_hud.update_timer = false;
        }
        
    break;
	
	case CAPSULE_STATE.BREAK:
        
        if --wait_timer < 0
        {
            for (var _i = 0; _i < 8; _i++)
	        {
	            with instance_create(x - 28 + 7 * _i, y, obj_animal)
				{
					state = ANIMAL_STATE.CAPSULE;
					state_timer = 154 - _i * 8;
				}
	        }
			
	        state = CAPSULE_STATE.SPAWN_ANIMALS;
	        wait_timer = 180;
			gate_obj.animator.start(gate_obj.sprite_index, 0, 2, 4);
        }
        
    break; 
	
    case CAPSULE_STATE.SPAWN_ANIMALS:
        
        if obj_game.frame_counter % 8 == 0
        {
			with instance_create(x + irandom_range(-25, 25), y, obj_animal)
			{
				state = ANIMAL_STATE.CAPSULE;
				state_timer = 12;
			}
        }
        else if --wait_timer == 0
        {
            state = CAPSULE_STATE.WAIT_ANIMALS;
        }
        
    break;
	
    case CAPSULE_STATE.WAIT_ANIMALS:
		
		var _start_results = true;
		
		with obj_animal
		{
			if instance_is_drawn()
			{
				_start_results = false; break;
			}
		}
		
	    if _start_results
	    {
	        audio_play_bgm(snd_bgm_actclear);
	        instance_create(0, 0, obj_gui_results);
			
	        state++;
	    }
		
	break;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	solid_object(player_get(_p), SOLID_TYPE.FULL);
}