// If detached from Sol, run m_hurt routine
if (vel_x != 0)
{
	hurt_players();
}

if (flip_timer++ == 8)
{
	flip_timer = 0;
	image_xscale = -image_xscale;
}

x += vel_x;