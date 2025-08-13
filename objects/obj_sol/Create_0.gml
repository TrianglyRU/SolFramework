enum SOLSTATE
{
	ROAM,
	SHOOT
}

#macro SOL_FIREBALL_COUNT 4

// Inherit the parent event
event_inherited();

obj_set_hitbox(6, 6);
obj_set_priority(4);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

state = SOLSTATE.ROAM;
angle = 0;
angle_step = 360 / SOL_FIREBALL_COUNT;
fireballs = [];

for (var _i = 0; _i < SOL_FIREBALL_COUNT; _i++)
{
	var _new_angle = angle + angle_step * _i;
	var _x = math_oscillate_x(x, _new_angle, 16);
	var _y = math_oscillate_y(y, _new_angle, 16);
	
	fireballs[_i] = instance_create_child(_x, _y, obj_sol_fireball);
}