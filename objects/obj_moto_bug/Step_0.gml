// Feather ignore GM2044

// Inherit the parent event
event_inherited();

if !is_valid
{
	return;
}

switch state
{
	case MOTOBUG_STATE.INIT:
	
		y += vel_y;
		vel_y += 0.21875;
		
		var _floor_dist = collision_tile_v(x, bbox_bottom, 1)[0];
		
		if _floor_dist < 0
		{
			y += _floor_dist;
			vel_y = 0;
			state = MOTOBUG_STATE.WAIT;
			image_xscale *= -1;
		}
		
	break;
	
	case MOTOBUG_STATE.WAIT:
	
		if --move_timer < 0
		{
			image_xscale *= -1;
			visible = true;
			state = MOTOBUG_STATE.ROAM;
			vel_x = -sign(image_xscale);
			animator.start(sprite_index, 0, 0, 8);
		}
		
	break;
	
	case MOTOBUG_STATE.ROAM:
	
		x += vel_x;
		
		var _floor_dist = collision_tile_v(x, bbox_bottom, 1)[0];
		
		if _floor_dist >= 12 || _floor_dist < -8
		{
			state = MOTOBUG_STATE.WAIT;
			move_timer = 59;
			vel_x *= -1;
			timer = 0;
			image_index = 0;
			
			break;
		}
		
		y += _floor_dist;

		if --smoke_timer < 0
		{
			smoke_timer = 15;
			instance_create(x + 19 * image_xscale, y, obj_moto_bug_smoke);
		}
		
	break;
}