enum SIGNPOSTSTATE
{
	IDLE,
	ROTATE,
	MOVE_PLAYER
}

// Inherit the parent event
event_inherited();

obj_rm_stage.end_bound = x + camera_get_width(0) * 0.5;
state = SIGNPOSTSTATE.IDLE;
sign_spin_timer = 0;
sign_spin_cycle = 0;
player_object = noone;
sign_char_frame = 4;
ring_sparkle_timer = 0;
ring_sparkle_id = 0;
ring_sparkle_pos =
[
	-24, 8, -16, 24, 0, 16, -24, 24,	// x
	-16, 8,  0, -8, -8, 0,   8,  16		// y
];

obj_set_priority(5);
obj_set_culling(ACTIVEIF.INBOUNDS);