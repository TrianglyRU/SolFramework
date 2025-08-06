enum PUSHABLEBLOCKSTATE
{
	GROUND,
	LEDGE,
	FALL
}
	
// Inherit the parent event
event_inherited();

state = PUSHABLEBLOCKSTATE.GROUND;
vel_x = 0;
vel_y = 0;
direction_x = 0;

obj_set_priority(4);
obj_set_culling(ACTIVEIF.INBOUNDS);
obj_set_solid(16, 16);