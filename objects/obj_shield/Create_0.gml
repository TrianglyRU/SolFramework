/// @method clear_fire_shield_dash()
clear_fire_shield_dash = function()
{
	obj_set_anim(spr_shield_fire, 2, 0, 0);
	
	if (vd_target_player.shield_state == SHIELDSTATE.ACTIVE)
	{
		vd_target_player.shield_state = SHIELDSTATE.DISABLED;
	}
				
	vd_target_player.air_lock_flag = false;
}

// Inherit the parent event
event_inherited();

var _shield = global.player_shields[vd_target_player.player_index];

obj_set_priority(_shield == SHIELD.FIRE ? 3 : 1);
obj_set_culling(ACTIVEIF.ENGINE_RUNNING);

switch (_shield)
{
	case SHIELD.NORMAL:
		obj_set_anim(spr_shield, 1, 0, 0);
	break;
	
	case SHIELD.BUBBLE:
		obj_set_anim(spr_shield_bubble, 2, 0, 0);
	break;
	
	case SHIELD.FIRE:
		obj_set_anim(spr_shield_fire, 2, 0, 0);	
	break;
	
	case SHIELD.LIGHTNING:
		obj_set_anim(spr_shield_lightning, 2, 0, 0);
	break;
}