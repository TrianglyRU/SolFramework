enum AIRBUBBLERSTATE
{
	IDLE,
	PRODUCE
}

/// @method set_delay()
set_delay = function()
{
	return irandom_range(128, 255);
}

// Inherit the parent event
event_inherited();

obj_set_priority(1);
obj_set_culling(ACTIVEIF.INBOUNDS);
obj_set_anim(sprite_index, 16, 0, 0);

state = AIRBUBBLERSTATE.IDLE;
wait_time = set_delay();
wait_cycle = 0;
random_time = 0;
bubbles_to_spawn = 0;
bubble_id = 0;
bubble_id_large = 0;
type_array_to_use = 0;
type_array =
[
	[0, 0, 0, 0, 1, 0],
	[0, 0, 0, 1, 0, 0],
	[1, 0, 1, 0, 0, 0],
	[0, 1, 0, 0, 1, 0]
];