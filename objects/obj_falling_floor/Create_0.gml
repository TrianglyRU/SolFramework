enum FALLINGFLOORSTATE
{
	IDLE,
	FALL
}

// Inherit the parent event
event_inherited();

obj_set_priority(5);
obj_set_solid(32, 8);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

state = FALLINGFLOORSTATE.IDLE;
wait_timer = 8;
fall_flag = false;
corner_x = floor(x - sprite_get_xoffset(sprite_index));
corner_y = floor(y - sprite_get_yoffset(sprite_index));
width = sprite_get_width(sprite_index);
height = sprite_get_height(sprite_index);