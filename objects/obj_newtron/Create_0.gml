enum NEWTRONTYPE
{
	FALL,
	FIRE
}

enum NEWTRONSTATE
{
	FIND_TARGET,
	FALL,
	FLOOR,
	FLY,
	FIRE
}

/// @method destroy()
destroy = function()
{
	instance_destroy();
}

// Inherit the parent event
event_inherited();

obj_set_priority(4);
obj_set_hitbox(20, 16);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

state = NEWTRONSTATE.FIND_TARGET;
vel_y = 0;
target_player = noone;
shot_flag = false;