if (!obj_rm_stage.water_enabled || y < obj_rm_stage.water_level || !obj_is_visible())
{
	exit;
}

switch (state)
{
	case AIRBUBBLERSTATE.IDLE:
	
		if (--wait_time != 0)
		{
			break;
		}
		
		type_array_to_use = irandom_range(0, 3);
		bubbles_to_spawn = irandom_range(1, 6);
		bubble_id_large = irandom_range(0, bubbles_to_spawn - 1);
		bubble_id = 0;
		state = AIRBUBBLERSTATE.PRODUCE;
		
		// fallthrough to AIRBUBBLER_STATE_PRODUCE
		
	case AIRBUBBLERSTATE.PRODUCE:
	
		if (--random_time > 0)
		{
			break;
		}
		
		var _bubble_type = BUBBLE.LARGE;
		
		if (bubble_id != bubble_id_large || ((wait_cycle + 1) % (vd_cycles_to_skip + 1)) == 1)
		{
			_bubble_type = type_array[type_array_to_use][bubble_id];
		}
		
		var _object = instance_create(x + irandom_range(-8, 7), y, obj_bubble, 
		{
			vd_bubble_type: _bubble_type,
			vd_wobble_direction: choose(DIRECTION.NEGATIVE, DIRECTION.POSITIVE)
		});
		
		with (_object)
		{
			image_index = _bubble_type == BUBBLE.LARGE ? 1 : 0;
		}
		
		if (--bubbles_to_spawn > 0)
		{
			bubble_id++;
			random_time = irandom_range(0, 31);
			
			break;
		}
		
		wait_time = define_delay();
		wait_cycle++;
		state = AIRBUBBLERSTATE.IDLE;

	break;
}