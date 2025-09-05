// Inherit the parent event
event_inherited();
event_animator();

m_bubble_shield_animation = function()
{
	animator.start(spr_shield_bubble, 0, 0, 2);
}

m_bubble_shield_drop_animation = function()
{
	animator.start(spr_shield_bubble_drop, 0, 3, 6);
}

m_bubble_shield_bounce_animation = function()
{
	animator.start(spr_shield_bubble_bounce, 0, 2, 6);
}

m_fire_shield_animation = function()
{
	animator.start(spr_shield_fire, 0, 0, 2);
}

m_reset_fire_shield_dash = function()
{
	m_fire_shield_animation();
	
	if player.shield_state == SHIELD_STATE.ACTIVE
	{
		player.shield_state = SHIELD_STATE.DISABLED;
	}
	
	player.air_lock_flag = false;
}

var _shield = global.player_shields[player.player_index];

switch _shield
{
	case SHIELD.NORMAL:
		animator.start(spr_shield, 0, 0, 1);
	break;
	
	case SHIELD.BUBBLE:
		m_bubble_shield_animation();
	break;
	
	case SHIELD.FIRE:
		m_fire_shield_animation();
	break;
	
	case SHIELD.LIGHTNING:
		animator.start(spr_shield_lightning, 0, 0, 2);
	break;
}

depth = draw_depth(_shield == SHIELD.FIRE ? 30 : 10);