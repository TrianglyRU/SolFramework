enum PLATFORMSTATE
{
	MOVE,
	FALL
}
	
// Inherit the parent event
event_inherited();

state = PLATFORMSTATE.MOVE;
player_touch = false;
wait_timer = 0;
weight = 0;
vel_y = 0;

obj_set_priority(5);
obj_set_solid(30, 8);
obj_set_culling(CULLING.ORIGINRESPAWN);

event_perform(ev_step, ev_step_normal);