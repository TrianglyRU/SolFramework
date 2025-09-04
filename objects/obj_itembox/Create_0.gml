// Inherit the parent event
event_inherited();

enum ITEMBOX_STATE
{
	IDLE,
	FALLING,
	DESTROYED
}

depth = m_get_layer_depth(40);
outside_action = OUTSIDE_ACTION.RESPAWN;
state = ITEMBOX_STATE.IDLE;
vel_y = 0;
itembox_type = image_index;

if itembox_type >= 9
{
	itembox_type = 9 + global.player_main;
}

var _sprite = spr_itembox_static;

switch itembox_type
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

m_animation_start(_sprite, itembox_type == 0 ? 0 : 1, 0, 2);