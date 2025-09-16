/// @description Base Enemy Code
if instance_exists(obj_water_flash) && floor(y) >= obj_water.y
{
	destroy(player_get(0));
}
else for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);

	if !collision_player(_player)
	{
		continue;
	}
		
	var _action_check = false;
	var _tails_check = false;
	var _inv_check = false;
	
	if _player.is_true_glide() || _player.animation == ANIM.HAMMERDASH || _player.animation == ANIM.SPIN || _player.action == ACTION.SPINDASH
	{
		_action_check = true;
	}
		
	if _player.action == ACTION.FLIGHT
	{
		var _vector = math_get_vector_rounded(_player.x - x, _player.y - y);
		
		if math_get_quadrant(_vector) == QUADRANT.DOWN
		{
			_tails_check = true;
		}
	}
		
	if _player.super_timer > 0 || _player.item_inv_timer > 0
	{
		_inv_check = true; 
	}
	
	if _action_check || _tails_check || _inv_check
	{
		if !_player.is_grounded
		{
			if floor(_player.y) >= floor(y) || _player.vel_y < 0
			{
				_player.vel_y -= _player.vel_y < 0 ? -1 : 1;
			}
			else if _player.vel_y > 0
			{
				_player.vel_y *= -1;
			}
		}
		
		destroy(_player);
		input_set_rumble(_p, 0.05, INPUT_RUMBLE_LIGHT);
	}
	else
	{
		_player.hurt();
	}
}