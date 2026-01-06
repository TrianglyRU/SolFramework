// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum ITEMBOX_STATE
{
	IDLE,
	FALLING,
	DESTROYED
}

depth = draw_depth(40);
state = ITEMBOX_STATE.IDLE;
vel_y = 0;
itembox_type = image_index;
animator.start(spr_itembox, min(itembox_type, 1), 0, 2);