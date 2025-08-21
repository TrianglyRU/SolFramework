enum CRABMEATSTATE
{
	INIT,
	MOVE,
	WAIT
}

/// @method is_on_slope()
is_on_slope = function()
{
	return angle >= 8.44 && angle <= 351.56;
}

/// @method update_move_sprite()
update_move_sprite = function()
{
	if (self.is_on_slope())
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

// Inherit the parent event
event_inherited();

obj_set_priority(3);
obj_set_hitbox(16, 16);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

state = CRABMEATSTATE.INIT;
state_timer = 0;
shot_flag = true;
vel_x = 0.5 * image_xscale;
vel_y = 0;
angle = 0;