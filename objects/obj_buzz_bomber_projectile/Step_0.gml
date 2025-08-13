switch (sprite_index)
{
	case -1:
	
		if (--wait_timer >= 0)
		{
			break;
		}
		
		obj_set_anim(spr_buzz_bomber_projectile_flare, 8, 0, 1);
	
	break;
	
	case spr_buzz_bomber_projectile_flare:
	
		if (obj_is_anim_ended())
		{
			obj_set_anim(spr_badnik_projectile, 2, 0, 0);
		}
	
	break;
	
	case spr_badnik_projectile:
		
		if (cull_parent != noone)
		{
			cull_parent = noone;
		}
		
		// Inherit the parent event
		event_inherited();
		
	break;
}