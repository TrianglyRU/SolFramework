/// @self obj_player
/// @function scr_player_glide()
function scr_player_glide()
{
	gml_pragma("forceinline");
	
	if (self.is_not_true_glide())
	{
	    return;
	}

	var _angle_inc = 2.8125;
	var _glide_grv = 0.125;
	var _slide_frc = 0.09375;

	// spd_ground is a gliding speed value
	switch (action_state)
	{
	    case GLIDE_STATE.AIR:
		
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
			
			facing = abs(glide_angle) < 90 ? -1 : 1; 
	        vel_x = spd_ground * -dcos(glide_angle);
			
	        if (vel_y < 0.5)
	        {
	            grv = _glide_grv;
	        }
	        else
	        {
	            grv = -_glide_grv;
	        }
			
	        if (!input_down.action_any)
	        {
				vel_x *= 0.25;
				self.release_glide(0);
	        }
			
	    break;

	    case GLIDE_STATE.GROUND:
		
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
	            self.land();
				
	            animation = ANIM.GLIDE_GROUND;	// Keep the animation
	            ground_lock_timer = 16;
	            spd_ground = 0;
				image_index = 1;
				
	            break;
	        }
			
	        if (glide_value % 4 == 0)
	        {
	            instance_create(x, y + radius_y + 1, obj_dust_skid);
	        }
			
	        if (glide_value > 0 && glide_value % 8 == 0)
	        {
	            audio_play_sfx(snd_slide);
	        }
			
	        glide_value++;
			
	    break;
	}
}