if current_level < target_level
{
	current_level++;
}
else if current_level > target_level
{
	current_level--;
}

switch room
{
	case rm_stage_dwz0:
		y = current_level;
	break;
	
	default:
		y = math_oscillate_y(current_level, obj_game.frame_counter * ANGLE_INCREMENT, 10, 1, 90);
}

obj_game.distortion_bound = y;
obj_game.palette_bound = y;