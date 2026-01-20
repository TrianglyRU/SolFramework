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

with obj_player
{
	var _water_run_level = other.y - radius_y;
	
	if !run_on_water
	{
		if vel_y == 0 && abs(vel_x) >= 7 && floor(y) == _water_run_level
		{
			run_on_water = true;
			facing = sign(vel_x);
			
			with instance_create(0, 0, obj_water_trail)
			{
				player = other.id;
			}
		}
	}	
	else if input_press_action_any()
	{
		// S3K's chopped-off version of the jump routine to make player jump if they weren't grounded
		run_on_water = false;
		radius_x = radius_x_spin;
		radius_y = radius_y_spin;
		is_jumping = true;
		is_grounded = false;
		animation = ANIM.SPIN;
		vel_y = jump_vel;			// S3K does not check if the player is Knuckles and overrides vel_y with -6.5
		
		audio_play_sfx(snd_jump);	// S3K does not play the sound, so if the game hasn't processed a jump via its default routine yet... yikes!
	}
	else if floor(y) >= _water_run_level && abs(vel_x) >= 7
	{
		y = _water_run_level;
		vel_y = 0;
		
		if !is_grounded && !input_press.left && !input_press.right
		{
			vel_x -= 0.046875 * sign(vel_x);
		}
	}
	else
	{
		run_on_water = false;
	}
}