switch state
{
    case CAPSULE_STATE.IDLE:
        
        if button_obj.y > button_obj.ystart
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
			with instance_create(x + irandom_range(-25, 24), y, obj_animal)
			{
				state = ANIMAL_STATE.CAPSULE;
				state_timer = 12;
			}
        }
        else if --wait_timer == 0
        {
            state = CAPSULE_STATE.CHECK_RESULTS;
        }
        
    break;
	
    case CAPSULE_STATE.CHECK_RESULTS:
		
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
			state = CAPSULE_STATE.RESULTS;
			instance_create(0, 0, obj_gui_results);
	    }
			
	break;
}

var _is_results_state = state == CAPSULE_STATE.RESULTS;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if _player != noone
	{
		if _is_results_state && _player.is_grounded
		{
			_player.set_victory_pose();
		}
	}
	
	solid_object(_player, SOLID_TYPE.FULL);
}