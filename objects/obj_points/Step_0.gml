if !visible
{
	for (var _p = 0; _p < PLAYER_COUNT; _p++)
	{
		var _player = player_get(_p);
		
		if _player.state < PLAYER_STATE.DEBUG_MODE && point_in_rectangle(floor(_player.x), floor(_player.y), x - 16, y - 16, x + 15, y + 15)
		{
			global.score_count += power(10, image_index + 2);
			outside_action = OUTSIDE_ACTION.DESTROY;
			visible = true;
			
			audio_play_sfx(snd_points);
			
			break;
		}
	}
}
else if --wait_timer < 0
{
	instance_destroy();
}