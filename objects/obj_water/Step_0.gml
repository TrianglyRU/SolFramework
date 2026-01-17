if current_level < target_level
{
	current_level++;
}
else if current_level > target_level
{
	current_level--;
}

y = iv_oscillate ? math_oscillate_y(current_level, obj_game.oscillation_angle, 10, 1, 90) : current_level;

obj_game.deformation_bound = y;
obj_game.palette_bound = y;