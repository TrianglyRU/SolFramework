if (!instance_exists(vd_target_player) || vd_target_player.shield == SHIELD.NONE)
{
    instance_destroy();
    exit;
}

switch (vd_target_player.shield)
{
    case SHIELD.FIRE:
	
        if (sprite_index != spr_shield_fire_dash)
        {
			obj_set_priority(image_index % 2 == 0 ? 3 : 1);
        }
		
    break;
    
    case SHIELD.LIGHTNING:
		
		if (anim_order_index == 21)
		{
			obj_set_priority(3);
		}
		else if (anim_order_index == 0)
		{
			obj_set_priority(1);
		}
		
    break;
}