// Feather ignore GM2044

// Inherit the parent event
event_inherited();

switch state
{
	case MOTOBUGSTATE.INIT:
	
		y += vel_y;
		vel_y += 0.21875;
		
		var _floor_dist = collision_tile_v(x, y + 14, 1)[0];
		
		if _floor_dist < 0
		{
			y += _floor_dist;
			vel_y = 0;
			state = MOTOBUGSTATE.WAIT;
			image_xscale *= -1;
		}
		
	break;
	
	case MOTOBUGSTATE.WAIT:
	
		if --move_timer < 0
		{
			image_xscale *= -1;
			visible = true;
			state = MOTOBUGSTATE.ROAM;
			vel_x = -sign(image_xscale);
			
			m_animation_start(sprite_index, 0, 0, 8);
		}
		
	break;
	
	case MOTOBUGSTATE.ROAM:
	
		x += vel_x;
		
		var _floor_dist = collision_tile_v(x, y + 14, 1)[0];
		
		if _floor_dist >= 12 || _floor_dist < -8
		{
			state = MOTOBUGSTATE.WAIT;
			move_timer = 59;
			vel_x *= -1;
			image_timer = 0;
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