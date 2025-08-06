var _shield = global.player_shields[vd_target_player.player_index];
if (!instance_exists(vd_target_player) || _shield == SHIELD.NONE)
{
    instance_destroy();	
    return;
}

switch (_shield)
{
    case SHIELD.FIRE:
	
        if (sprite_index != spr_shield_fire_dash)
        {
			obj_set_priority(image_index % 2 == 0 ? 3 : 1);
        }
		
    break;
    
    case SHIELD.LIGHTNING:
		
		if (image_index == 21)
		{
			obj_set_priority(3);
		}
		else if (image_index == 0 || image_index == 39)
		{
			obj_set_priority(1);
		}
		
    break;
}