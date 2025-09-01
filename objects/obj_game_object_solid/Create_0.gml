// Inherit the parent event
event_inherited();

solid_offsets = [];
solid_balance = false;
solid_push = array_create(PLAYER_MAX_COUNT, false);
solid_touch = array_create(PLAYER_MAX_COUNT, SOLID_TOUCH.NONE);

enum SOLID_TYPE
{
	ITEM_BOX,
	SIDES,
	FULL,
	FULL_RESET,
	TOP,
	TOP_RESET
}

enum SOLID_TOUCH
{
    NONE,
	TOP,
	BOTTOM,
	LEFT,
	RIGHT
}