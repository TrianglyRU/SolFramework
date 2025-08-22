/// @method stop_anim()
stop_anim = function()
{
	obj_stop_anim(0);
}

// Inherit the parent event
event_inherited();

obj_set_priority(5);
obj_set_solid(16, 8);
obj_set_culling(ACTIVEIF.INBOUNDS);

launch_force = 10;