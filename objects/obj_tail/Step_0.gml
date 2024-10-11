if (!instance_exists(vd_target_player) || vd_target_player.vd_player_type != PLAYER.TAILS)
{
	instance_destroy();
	exit;
}

tail_offset_x = 0;
tail_offset_y = 0;

switch (vd_target_player.animation)
{
	case ANIM.IDLE:
	case ANIM.WAIT:
	case ANIM.DUCK:
	case ANIM.LOOKUP:
		obj_set_anim(spr_tails_tail_idle, 8, 0, 0);
	break;
	
	case ANIM.FLY:
	case ANIM.FLY_TIRED:
	
		var _duration = 1;
		
		if (vd_target_player.vel_y >= 0 || vd_target_player.animation == ANIM.FLY_TIRED)
		{
			_duration = 2;
		}
		
		obj_set_anim(spr_tails_tail_fly, _duration, 0, 0, true);
		
	break;
	
	case ANIM.PUSH:
	case ANIM.SKID:
	case ANIM.SPIN:
	case ANIM.GRAB:
	case ANIM.BALANCE:
	case ANIM.SPINDASH:
	
		if (vd_target_player.animation == ANIM.SPINDASH || vd_target_player.animation == ANIM.GRAB)
		{
			tail_offset_x += 5;
		}
		else if (vd_target_player.animation != ANIM.SPIN)
		{
			tail_offset_x += 7;
			tail_offset_y += 5;
		}
		
		obj_set_anim(spr_tails_tail, 4, 0, 0);
		
	break;
	
	default:
		sprite_index = -1;
}

if (vd_target_player.animation != ANIM.SPIN)
{
	image_angle = vd_target_player.image_angle;
}
else if (vd_target_player.is_grounded)
{
	image_angle = vd_target_player.visual_angle;
}
else
{
	var _x = vd_target_player.x;
	var _y = vd_target_player.y;
	
	image_angle = point_direction(_x, _y, _x + vd_target_player.vel_x, _y + vd_target_player.vel_y);
	
	if (vd_target_player.image_xscale == DIRECTION.NEGATIVE)
	{
		image_angle += 180;
	}
	
	if (global.rotation_mode == ROTATION.CLASSIC)
	{
		image_angle = ceil((image_angle - 22.5) / 45) * 45;
	}
}

if (vd_target_player.animation == ANIM.SPIN && vd_target_player.is_grounded )
{
	image_xscale = sign(vd_target_player.spd_ground);
}
else
{
	image_xscale = vd_target_player.image_xscale;
}