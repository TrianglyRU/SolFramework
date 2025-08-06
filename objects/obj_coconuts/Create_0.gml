enum COCONUTSSTATE
{
	IDLE,
	START_CLIMB,
	START_THROW,
	CLIMB,
	THROW
}

// Inherit the parent event
event_inherited();
	
state = COCONUTSSTATE.IDLE;
state_timer = 16;
vel_y = 0;
climb_table_index = 0;
attack_timer = 0;
attack_flag = false;
hand_frame = 0;
climb_data =
[
	// vel_y	timer
	-1,			32,
	 1,			24, 
    -1,			16,
	 1,			40,
    -1,			32,
	 1,			16
];

obj_set_priority(4);
obj_set_hitbox(12, 16);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);