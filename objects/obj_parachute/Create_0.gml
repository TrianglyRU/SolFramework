// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum PARACHUTE_STATE
{
	IDLE,
	CARRY_PLAYER,
	LEFTOVER
}

sync_with_player = function()
{
	x = player.x;
	y = player.y - player.radius_y + player.radius_y_normal - 39;
	vel_x = player.vel_x;
	vel_y = player.vel_y;
}

depth = draw_depth(10);
state = PARACHUTE_STATE.IDLE;
player = noone;
vel_x = 0;
vel_y = 0;