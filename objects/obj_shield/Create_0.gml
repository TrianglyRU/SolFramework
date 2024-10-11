#region METHODS

/// @method clear_fire_shield_dash()
clear_fire_shield_dash = function()
{
	with (vd_target_player)
	{
		if (shield_state == SHIELDSTATE.ACTIVE)
		{
			shield_state = SHIELDSTATE.DISABLED;
		}
				
		air_lock_flag = false;
	}
	
	obj_set_anim(spr_shield_fire, 2);
}

/// @method set_bubble_shield_animation()
set_bubble_shield_animation = function()
{
	var _order_data =
	[
		0, 9, 0, 9, 0, 9, 1, 10, 1, 10, 1, 10,
		2, 9, 2, 9, 2, 9, 3, 10, 3, 10, 3, 10,
		4, 9, 4, 9, 4, 9, 5, 10, 5, 10, 5, 10,
		6, 9, 6, 9, 6, 9, 7, 10, 7, 10, 7, 10,
		8, 9, 8, 9, 8, 9
	];
	
	obj_set_anim(spr_shield_bubble, 2, _order_data, 0);
}

#endregion

// Inherit the parent event
event_inherited();
	
switch (vd_target_player.shield)
{
	case SHIELD.NORMAL:
		
		obj_set_anim(spr_shield, 4);
		obj_set_priority(1);
		
		image_alpha = 0.5;
		
	break;
			
	case SHIELD.BUBBLE:
	
		set_bubble_shield_animation();
		obj_set_priority(1);
		
	break;
		
	case SHIELD.FIRE:
		
		obj_set_anim(spr_shield_fire, 2);
		obj_set_priority(3);
			
	break;
		
	case SHIELD.LIGHTNING:
		
		var _order_data =
		[
			0,  0,  1,  1,  2,  2,  3,  3,  4,  4,  5,  5,  6,  6,  7,  7,  8,  8,
			9,  10, 11,
			12, 12, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20,
			9,  10, 11
		];
		
		obj_set_anim(spr_shield_lightning, 2, _order_data, 0);
		obj_set_priority(1);
		
	break;
}

obj_set_culling(CULLING.PAUSEONLY);