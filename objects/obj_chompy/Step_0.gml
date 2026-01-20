// Inherit the parent event
event_inherited();

if clear_jump
{
	if angle != 0
	{
		image_xscale *= -1;
	}
	
	vel_x = -2 * sign(image_xscale);
	vel_y = CHOMPY_VEL_Y_DEFAULT;
	angle = 0;
	clear_jump = false
	
	y = ystart;
	depth = draw_depth(40 + 10 * sign(image_xscale), culler.depth_start);
}

x += vel_x;
y += vel_y;
vel_y += 0.1875;
angle += 1.60125 * sign(image_xscale);

if vel_y > abs(CHOMPY_VEL_Y_DEFAULT)
{
	clear_jump = true;
}