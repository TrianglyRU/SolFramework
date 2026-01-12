// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

enum FALLINGFLOORSTATE
{
	IDLE,
	FALL
}

depth = draw_depth(40); // 50 by default
culler.action = CULL_ACTION.RESET;
state = FALLINGFLOORSTATE.IDLE;
wait_timer = 8;
fall_flag = false;
corner_x = floor(x - sprite_get_xoffset(sprite_index));
corner_y = floor(y - sprite_get_yoffset(sprite_index));
width = sprite_get_width(sprite_index);
height = sprite_get_height(sprite_index);