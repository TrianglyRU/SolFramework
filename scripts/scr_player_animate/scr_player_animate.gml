/// @function scr_player_animate
/// @self obj_player
function scr_player_animate()
{
	gml_pragma("forceinline");
	
	/// @method _ceil_angle
	var _ceil_angle = function(_angle)
	{
		return ceil((_angle - 22.5) / 45) * 45;
	}

	var _smooth_rotation = global.rotation_mode == ROTATION.MANIA;
	
	if (is_grounded)
	{
		var _target_angle = angle > 22.5 && angle < 337.5 ? angle : 0;
		
		if (_smooth_rotation)
		{
			var _diff = _target_angle - visual_angle;
			var _delta = abs(_diff);
			var _cw_delta = abs(_diff + 360);
			var _ccw_delta = abs(_diff - 360);
			
			if (_delta > _ccw_delta)
			{
			    _diff -= 360;
			} 
			else if (_delta > _cw_delta)
			{
			    _diff += 360;
			}
			
			visual_angle += _diff / ((abs(spd_ground) >= 6) ? 2 : 4);
			visual_angle %= 360;
			
			if (visual_angle < 0)
			{
			    visual_angle += 360;
			}
		}
		else
		{
			visual_angle = _ceil_angle(_target_angle);
		}
	}
	else
	{
		visual_angle = _smooth_rotation ? angle : _ceil_angle(angle);
	}
	
	if (animation == ANIM.SKID && obj_is_anim_ended())
	{
		if (!input_down.left && !input_down.right || !is_grounded || abs(spd_ground) < PARAM_SKID_SPEED_THRESHOLD)
		{
			animation = ANIM.MOVE;
		}			
	}
	
	switch (vd_player_type)
	{
		case PLAYER.SONIC:
			scr_player_animate_sonic();
		break;
		case PLAYER.TAILS:
			scr_player_animate_tails();
		break;
		case PLAYER.KNUCKLES:
			scr_player_animate_knuckles();
		break;
		case PLAYER.AMY:
			scr_player_animate_amy();
		break;
	}
	
	if (animation != ANIM.SPIN || anim_frame_change_flag)
	{
		image_xscale = facing;
	}
	
	image_angle = animation == ANIM.MOVE || animation == ANIM.HAMMERDASH ? visual_angle : 0;
}