if (!visible)
{
	for (var _p = 0; _p < PLAYER_COUNT; _p++)
	{
		var _player = player_get(_p);
		if (_player.state >= PLAYERSTATE.DEBUG_MODE)
		{
			continue;
		}
		
		var _dist_x = floor(_player.x) - x + 16;
		var _dist_y = floor(_player.y) - y + 16;
		
		if (_dist_x >= 0 && _dist_x < 32 && _dist_y >= 0 && _dist_y < 32)
		{
			visible = true;
			global.score_count += power(10, image_index + 2);
			
			audio_play_sfx(snd_points);
			obj_set_culling(ACTIVEIF.INBOUNDS_DELETE);
			break;
		}
	}
}
else if (--wait_timer < 0)
{
	instance_destroy();
}