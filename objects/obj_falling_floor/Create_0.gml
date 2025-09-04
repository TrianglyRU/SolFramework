// Inherit the parent event
event_inherited();

enum FALLINGFLOORSTATE
{
	IDLE,
	FALL
}

outside_action = OUTSIDE_ACTION.RESPAWN;

depth = m_get_layer_depth(50);
state = FALLINGFLOORSTATE.IDLE;
wait_timer = 8;
fall_flag = false;
corner_x = floor(x - sprite_get_xoffset(sprite_index));
corner_y = floor(y - sprite_get_yoffset(sprite_index));
width = sprite_get_width(sprite_index);
height = sprite_get_height(sprite_index);