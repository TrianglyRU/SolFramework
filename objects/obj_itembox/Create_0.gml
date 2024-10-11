enum ITEMBOXSTATE
{
	IDLE,
	FALL,
	DESTROYED
}

// Inherit the parent event
event_inherited();

state = ITEMBOXSTATE.IDLE;
vel_y = 0;
itembox_type = image_index;

obj_set_priority(4);
obj_set_hitbox(16, 16);
obj_set_solid(15, 15);
obj_set_culling(CULLING.RESPAWN);

var _sprite = spr_itembox_static;

if (itembox_type >= 9)
{
	itembox_type = 9 + player_get(0).vd_player_type;
}
	
switch (itembox_type)
{
	case 1: _sprite = spr_itembox_eggman; break;
	case 2: _sprite = spr_itembox_ring; break;
	case 3: _sprite = spr_itembox_shoes; break;
	case 4: _sprite = spr_itembox_shield; break;
	case 5: _sprite = spr_itembox_shield_bubble; break;
	case 6: _sprite = spr_itembox_shield_fire; break;
	case 7: _sprite = spr_itembox_shield_thunder; break;
	case 8: _sprite = spr_itembox_invincibility; break;
	case 9: _sprite = spr_itembox_sonic; break;
	case 10: _sprite = spr_itembox_tails; break;
	case 11: _sprite = spr_itembox_knuckles; break;
	case 12: _sprite = spr_itembox_amy; break;
}

/// @feather ignore GM1063
obj_set_anim(_sprite, 2, itembox_type == 0 ? 0 : [1, 0, 0, 2, 0, 0], 0);