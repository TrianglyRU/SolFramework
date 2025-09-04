// Inherit the parent event
event_inherited();

y += vel_y;
vel_y += 0.09375;

if y >= ystart - 192
{
	if y >= ystart
	{
		y = ystart;
		vel_y = CHOPPER_VEL_Y_DEFAULT;
	}
	
	if vel_y >= 0
	{
		if image_timer > 0
		{
			m_animation_clear(0);
		}
	}
	else if image_timer == 0
	{
		m_animation_start(sprite_index, 0, 0, 8);
	}
}
else
{
	image_duration = 4;
}