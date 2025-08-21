/// @function _ceil_angle()
function _ceil_angle(_angle)
{
	gml_pragma("forceinline");
	return ceil((_angle - 22.5) / 45) * 45;
}

/// @self obj_player
/// @function scr_player_animate()
function scr_player_animate()
{
	gml_pragma("forceinline");
	
	var _use_mania = global.rotation_mode == ROTATION.MANIA;
	var _range = global.rotation_range;
	
	var _min_angle = 22.5 + (_range == RANGE.SHALLOW ? 4 * ANGLE_INCREMENT : 0);
	var _max_angle = 337.5 - (_range == RANGE.SHALLOW ? 4 * ANGLE_INCREMENT : 0);
	
	if (is_grounded)
	{
		var _target_angle = angle > _min_angle && angle < _max_angle ? angle : 0;
		if (_use_mania)
		{
			if (angle <= 5.625 || angle >= 354.375)
			{
				visual_angle = 0;
			}
			else
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
		}
		else
		{
			visual_angle = _ceil_angle(_target_angle);
		}
	}
	else
	{
		visual_angle = _use_mania ? angle : _ceil_angle(angle);
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
	
	if (animation != ANIM.SPIN || anim_frame_changed)
	{
		image_xscale = facing;
	}
	
	image_angle = animation == ANIM.MOVE || animation == ANIM.HAMMERDASH ? visual_angle : 0;
}