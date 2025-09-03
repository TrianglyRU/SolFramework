// Inherit the parent event
event_inherited();

set_bubble_shield_anim = function()
{
	obj_set_anim(spr_shield_bubble, 2, 0, 0)
}

set_fire_shield_anim = function()
{
	obj_set_anim(spr_shield_fire, 2, 0, 0);
}

clear_fire_shield_dash = function()
{
	set_fire_shield_anim();
	
	if (vd_target_player.shield_state == SHIELD_STATE.ACTIVE)
	{
		vd_target_player.shield_state = SHIELD_STATE.DISABLED;
	}
				
	vd_target_player.air_lock_flag = false;
}

var _shield = global.player_shields[player.player_index];

switch _shield
{
	case SHIELD.NORMAL:
		obj_set_anim(spr_shield, 1, 0, 0);
	break;
	
	case SHIELD.BUBBLE:
		set_bubble_shield_anim();
	break;
	
	case SHIELD.FIRE:
		set_fire_shield_anim();
	break;
	
	case SHIELD.LIGHTNING:
		obj_set_anim(spr_shield_lightning, 2, 0, 0);
	break;
}

depth += _shield == SHIELD.FIRE ? 30 : 10;