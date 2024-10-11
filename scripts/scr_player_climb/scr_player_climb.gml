/// @function scr_player_climb()
/// @self obj_player
function scr_player_climb()
{
	gml_pragma("forceinline");
	
	if (action != ACTION.CLIMB)
	{
		exit;
	}

	var _steps_per_climb_value = 4;
	
	switch (action_state)
	{
		case CLIMBSTATE.NORMAL:
	
			if (x != xprevious || vel_x != 0)
			{
				release_glide(1);
				break;
			}
			
			var _max_animation_value = image_number * _steps_per_climb_value;
		
			if (input_down.up)
			{
				if (++climb_value > _max_animation_value)
				{
					climb_value = 0;
				}
				
				vel_y = -acc_climb;
			}
			else if (input_down.down)
			{
				if (--climb_value < 0)
				{
					climb_value = _max_animation_value;
				}
				
				vel_y = acc_climb;
			}
			else
			{
				vel_y = 0;
			}
		
			var _radius_x = radius_x;
			
			if (facing == DIRECTION.NEGATIVE)
			{
				_radius_x++;
			}
		
			if (vel_y < 0)
			{
				var _wall_dist = tile_find_h(x + _radius_x * facing, y - radius_y - 1, facing, tile_layer)[0];
				
				if (_wall_dist >= 4)
				{
					action_state = CLIMBSTATE.LEDGE;
					vel_y = 0;
					grv = 0;
					
					break;
				}
				
				if (_wall_dist != 0)
				{
					vel_y = 0;
				}
			
				var _ceil_dist = tile_find_v(x + _radius_x * facing, y - radius_y_normal + 1, DIRECTION.NEGATIVE, tile_layer)[0];
				
				if (_ceil_dist < 0)
				{
					y -= _ceil_dist;
					vel_y = 0;
				}
			}
			else
			{
				var _wall_dist = tile_find_h(x + _radius_x * facing, y + radius_y + 1, facing, tile_layer)[0];
				
				if (_wall_dist != 0)
				{
					release_glide(1);
					break;
				}
				
				var _floor_data = tile_find_v(x + _radius_x * facing, y + radius_y_normal, DIRECTION.POSITIVE, tile_layer);
				var _floor_dist = _floor_data[0];
				var _floor_angle = _floor_data[1];
				
				if (_floor_dist < 0)
				{
					land();
					
					y += _floor_dist + radius_y;
					angle = _floor_angle;
					animation = ANIM.IDLE;
					vel_y = 0;
					
					break;
				}
			}
			
			if (input_press.action_any)
			{
				animation = ANIM.SPIN;
				action = ACTION.NONE;
				is_jumping = true;		
				facing *= -1;
				vel_x = 3.5 * facing;
				vel_y = jump_min_vel;
				radius_x = radius_x_spin;
				radius_y = radius_y_spin;
				
				audio_play_sfx(snd_jump);
				reset_gravity();
				
				break;
			}
			
			if (vel_y != 0)
			{
				image_index = floor(climb_value / _steps_per_climb_value);
			}
	
		break;
	
		case CLIMBSTATE.LEDGE:
			
			if (animation != ANIM.CLIMB_LEDGE)
			{
				animation = ANIM.CLIMB_LEDGE;
				x += 3 * facing;
				y -= 3;
			}
			else if (anim_frame_change_flag)
			{
				switch (image_index)
				{
					case 1:
					
						x += 8 * facing;
						y -= 10;
						
					break;
				
					case 2:
					
						x -= 8 * facing;
						y -= 12;
						
					break;
				}
			}
			else if (obj_is_anim_ended())
			{
				land();
				
				animation = ANIM.IDLE;
				x += 8 * facing;
				y += 4;
				
				if (facing == DIRECTION.NEGATIVE)
				{
					x--;
				}
			}
	
		break;
	}
}