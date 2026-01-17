osc_angle = dsin(obj_game.oscillation_angle + iv_offset) * iv_range * 0.5;

x = math_oscillate_x(xstart, osc_angle, distance);
y = math_oscillate_y(ystart, osc_angle, distance);

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	solid_object(player_get(_p), SOLID_TYPE.TOP);
}