if (!obj_act_enemy())
{
	exit;
}

if (state == SOLSTATE.ROAM)
{
	var _player = player_get(0);
	var _dist_x = floor(_player.x) - floor(x);
	var _dist_y = floor(_player.y) - floor(y);
	
	if (abs(_dist_x) < 160 && abs(_dist_y) < 80 && _player.state < PLAYER_STATE.DEBUG_MODE)
	{
		state = SOLSTATE.SHOOT;
	}
}

x -= 0.25 * image_xscale;
angle = (angle - ANGLE_INCREMENT * image_xscale) % 360;

for (var _i = 0; _i < SOL_FIREBALL_COUNT; _i++)
{
	var _fireball = fireballs[_i];
	if (_fireball == noone)
	{
		continue;
	}
	
	// If the fireball is attached to Sol, run its hurt routine from here to make sure it
	// happens after Sol runs a collision with a player
	_fireball.hurt_players();
	
	var _new_angle = angle + angle_step * _i;
	var _new_x = math_oscillate_x(x, _new_angle, 16);
	var _new_y = math_oscillate_y(y, _new_angle, 16);
	
	_fireball.x = _new_x;
	_fireball.y = _new_y;
	
	if (state != SOLSTATE.SHOOT || _new_angle != 0)
	{
		continue;
	}
	
	// Throw the fireball
	_fireball.cull_parent = noone;
	_fireball.vel_x = -2 * image_xscale; 
	
	with (_fireball)
	{
		obj_set_culling(ACTIVEIF.INBOUNDS_DELETE);
	}
	
	fireballs[_i] = noone;
}