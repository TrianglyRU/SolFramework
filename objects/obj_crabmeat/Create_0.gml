// Inherit the parent event
event_inherited();

enum CRABMEAT_STATE
{
	INIT,
	MOVE,
	WAIT_OR_FIRE
}

m_is_on_slope = function()
{
	return angle >= 8.44 && angle <= 351.56;
}

m_update_move_sprite = function()
{
	if m_is_on_slope()
	{
		image_xscale = angle >= 180 ? -1 : 1;
		sprite_index = spr_crabmeat_move_angled;
	}
	else
	{
		image_xscale = 1;
		sprite_index = spr_crabmeat_move;
	}
}

depth += m_get_layer_depth(30);
outside_action = OUTSIDE_ACTION.RESPAWN;
state = CRABMEAT_STATE.INIT;
state_timer = 0;
shot_flag = true;
vel_x = 0.5 * image_xscale;
vel_y = 0;
angle = 0;