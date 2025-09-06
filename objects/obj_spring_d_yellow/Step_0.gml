if animator.timer < 0
{
	animator.clear(0);
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	var _prev_anim = _player.animation;
	var _touch_side = image_yscale >= 0 ? SOLID_TOUCH.TOP : SOLID_TOUCH.BOTTOM;
	
	solid_object(_player, SOLID_TYPE.FULL_RESET);
	
	if image_index != 0 || solid_touch[_p] != _touch_side
    {
        continue;
    }
	
	if image_xscale * (floor(_player.x) - x + 4 * image_xscale) < 0
	{
		continue;
	}
	
	if image_yscale >= 0
	{
		if iv_flip_player
		{
			_player.animation = launch_force > 10 ? ANIM.FLIP_EXTENDED : ANIM.FLIP;
		}
		else
		{
			_player.animation = ANIM.BOUNCE;
		}
		
		if _prev_anim == _player.animation
		{
			_player.animator.restart();
		}
	}
	
	var _result_force = iv_use_sine ? launch_force * dsin(45) : launch_force;
	
	_player.y += image_yscale * 8;
	_player.facing = image_xscale;
	_player.vel_x = _result_force * image_xscale;
	_player.vel_y = -_result_force * image_yscale;
	_player.reset_substate();
	
	animator.start(sprite_index, 1, 9, 1);
	
	audio_play_sfx(snd_spring);
	input_set_rumble(_p, 0.20, INPUT_RUMBLE_MEDIUM);
}