// Inherit the parent event
event_inherited();

if state != ITEMBOX_STATE.DESTROYED && itembox_type > 0
{
	if (image_index + 1) % 3 != 0
	{
		draw_sprite(spr_itemcard, itembox_type, floor(x), floor(y) - 3);
	}
}