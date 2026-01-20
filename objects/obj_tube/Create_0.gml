// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

enum TUBE_TYPE
{
	START_X,
	START_Y,
	KEEP_SPEED,
	STOP
}

depth = RENDER_DEPTH_PRIORITY;
ds_player_list = ds_list_create();