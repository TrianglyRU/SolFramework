/// @function scr_player_glide()
/// @self obj_player
function scr_player_glide()
{
	gml_pragma("forceinline");
	
	if (action != ACTION.GLIDE || action_state == GLIDESTATE.FALL)
	{
	    exit;
	}

	var _angle_inc = 2.8125;
	var _glide_grv = 0.125;
	var _slide_frc = 0.09375;

	switch (action_state)
	{
	    case GLIDESTATE.AIR:
		
	        if (spd_ground >= 4)
	        {
	            if (glide_angle % 180 == 0)
	            {
	                spd_ground = min(spd_ground + acc_glide, 24);
	            }
	        }
	        else
	        {
	            spd_ground += 0.03125;
	        }
			
	        if (glide_angle != 0 && input_down.left)
	        {
	            if (glide_angle > 0)
	            {
	                glide_angle = -glide_angle;
	            }
				
	            glide_angle += _angle_inc;
	        }
	        else if (glide_angle != 180 && input_down.right)
	        {
	            if (glide_angle < 0)
	            {
	                glide_angle = -glide_angle;
	            }
				
	            glide_angle += _angle_inc;
	        }
	        else if (glide_angle % 180 != 0)
	        {
	            glide_angle += _angle_inc;
	        }
			
	        vel_x = spd_ground * -dcos(glide_angle);
			
	        if (vel_y < 0.5)
	        {
	            grv = _glide_grv;
	        }
	        else
	        {
	            grv = -_glide_grv;
	        }
			
	        var _angle = abs(glide_angle) % 180;
			
	        if (_angle < 30 || _angle > 150)
	        {
	            image_index = 0;
	        }
	        else if (_angle < 60 || _angle > 120)
	        {
	            image_index = 1;
	        }
	        else
	        {
				image_index = 2;
	            facing = _angle < 90 ? DIRECTION.NEGATIVE : DIRECTION.POSITIVE; 
			}
			
	        if (!input_down.action_any)
	        {
				vel_x *= 0.25;
				release_glide(0);
	        }
			
	    break;

	    case GLIDESTATE.GROUND:
		
	        if (!input_down.action_any)
	        {
	            vel_x = 0;
	        }
	        else if (vel_x > 0)
	        {
	            vel_x = max(0, vel_x - _slide_frc);
	        }
	        else if (vel_x < 0)
	        {
	            vel_x = min(0, vel_x + _slide_frc);
	        }
			
	        if (vel_x == 0)
	        {
	            land();
				
	            animation = ANIM.GLIDE_GROUND;	// Keep the animation
	            ground_lock_timer = 16;
	            spd_ground = 0;
				image_index = 1;
				
	            break;
	        }
			
	        if (glide_value % 4 == 0)
	        {
	            instance_create(x, y + radius_y, obj_dust_skid);
	        }
			
	        if (glide_value > 0 && glide_value % 8 == 0)
	        {
	            audio_play_sfx(snd_slide);
	        }
			
	        glide_value++;
			
	    break;
	}
}