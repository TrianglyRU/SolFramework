visible = !visible;

if (display_timer < 24)
{
	x += vd_sparkle_id < 2 ? -2 : 2;
	y += vd_sparkle_id % 2 == 0 ? -2 : 2;
	display_timer++;
}
else
{
	instance_destroy();
}