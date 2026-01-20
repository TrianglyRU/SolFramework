// Inherit the parent event
event_inherited();

x += vel_x;
y += vel_y;
vel_y += 0.1875;

if vel_y >= 0
{
	var _floor_dist = collision_tile_v(x, bbox_bottom - 1, 1)[0];
	
	if _floor_dist < 0
	{
		y += _floor_dist;
		
		vel_y = -4;
		bounce++;
		
		if bounce == 4
		{
			bounce = 0;
			vel_x *= -1;
			image_xscale *= -1;
		}
	}
}

// Animate
if vel_y > 2 || vel_y < -3
{
    image_index = 0;
}
else if vel_y > 0.5 || vel_y < -2
{
    image_index = 1;
}
else
{
    image_index = 2;
}