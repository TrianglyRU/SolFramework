if timer < 128
{
    if timer == 96
    {
        speed_x *= 2;
        speed_y *= 2;
		
		if obj_game.fade_state == FADE_STATE.PLAIN_COLOUR
		{
			fade_perform_black(FADE_DIRECTION.IN, 1);
		}
		else
		{
			for (var _i = 0; _i < CAMERA_COUNT; _i++)
			{
				camera_toggle_movement(_i, true);
			}
		}
    }
    else if timer >= 8
    {
        offset_banner = min(offset_banner + speed_y, 0);
        offset_zonename = max(offset_zonename - speed_x, 0);
        offset_zone = max(offset_zone - speed_x, 0);
        offset_act = max(offset_act - speed_x, 0);
    }
}
else
{
    if timer == 192
    {
        instance_destroy();
    }
    else if timer >= 160
    {
        offset_zonename -= speed_x;
        offset_zone += speed_x;
        offset_act += speed_x;
    }
    else if timer >= 136
    {
        offset_banner -= speed_y;
    }
}

timer++;