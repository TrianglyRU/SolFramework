// Inherit the parent event
event_inherited();

enum LAMP_STATE
{
	IDLE,
	ROTATE,
	ACTIVE
}

m_activate = function()
{
	state = LAMP_STATE.ACTIVE;
	m_animation_start(sprite_index, 0, 0, 4);
}

depth -= 1;
state = LAMP_STATE.IDLE;
angle = 0;
radius = sprite_height * 0.5 + 3;