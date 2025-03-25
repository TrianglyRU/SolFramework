visible = global.debug_collision > 0;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	var _angle_quad = math_get_quadrant(_player.angle);
	
	if (!_player.is_grounded || _angle_quad != QUADRANT.RIGHT)
	{
		continue;
	}
	
	var _player_x = floor(_player.x);
	var _player_y = floor(_player.y);
	
	if (_player_x < bbox_left || _player_x >= bbox_right || _player_y < bbox_top || _player_y >= bbox_bottom)
	{
		continue;
	}
	
	with (_player)
	{
		if (spd_ground >= 2.5 && angle <= 90 && x < xprevious)
		{
			x = xprevious;
			image_angle = 90;
			angle = 90;
			visual_angle = 90;
		}
	}
}