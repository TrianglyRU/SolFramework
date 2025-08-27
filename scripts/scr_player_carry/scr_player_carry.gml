/// @function _attach_to_tails()
function _attach_to_tails(_who, _tails)
{
	gml_pragma("forceinline");
		
	var _target_x = _tails.x;
	var _target_y = _tails.y + 28;
	
	_who.x = _target_x;
	_who.y = _target_y;
	_who.image_xscale = _tails.facing;
	_who.facing = _tails.facing;
	_who.vel_x = _tails.vel_x;
	_who.vel_y = _tails.vel_y;
	_tails.carry_target_x = _target_x;
	_tails.carry_target_y = _target_y;
}

/// @self obj_player
/// @function scr_player_carry()
function scr_player_carry()
{
	gml_pragma("forceinline");
	
	if (player_type != PLAYER.TAILS)
	{
		return;
	}

	if (carry_cooldown > 0)
	{
		carry_cooldown--;
		return;
	}

	if (carry_target == noone)
	{
		if (action != ACTION.FLIGHT)
		{
			return;
		}

		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			if (_p == player_index)
			{
				continue;
			}
		
			var _player = player_get(_p);	
			if (_player.action == ACTION.SPINDASH || _player.action == ACTION.CARRIED || _player.state != PLAYERSTATE.DEFAULT)
			{
				continue;
			}
		
			var _dist_x = floor(_player.x) - floor(x);
			var _dist_y = floor(_player.y) - floor(y);
		
			if (abs(_dist_x) < 16 && abs(_dist_y) - 32 < 16)
			{
				_player.reset_substate();		
				_player.animation = ANIM.GRAB;
				_player.action = ACTION.CARRIED;
				
				carry_target = _player;
				
				audio_play_sfx(snd_grab);
				_attach_to_tails(_player, id);
				
				break;
			}	
		}
	}
	else if (carry_target.action != ACTION.CARRIED)
	{
		self.clear_carry();
	}
	else if (carry_target.input_press.action_any)
	{
		carry_target.is_jumping = true;
		carry_target.action = ACTION.NONE;
		carry_target.animation = ANIM.SPIN;
		carry_target.radius_x = carry_target.radius_x_spin;
		carry_target.radius_y = carry_target.radius_y_spin;
		carry_target.vel_y = carry_target.jump_min_vel;
		
		if (carry_target.input_down.left)
		{
			carry_target.vel_x = -2;
		}
		else if (carry_target.input_down.right)
		{
			carry_target.vel_x = 2;
		}
		
		carry_target = noone;
		carry_cooldown = 18;
		
		audio_play_sfx(snd_jump);
	}
	else if floor(carry_target.x) != floor(carry_target_x) || floor(carry_target.y) != floor(carry_target_y)
	{
		self.clear_carry();
	}
	else
	{
		_attach_to_tails(carry_target, id);
		
		with (carry_target)
		{
			scr_player_collision_air();
		}
	}
}