/// @function scr_player_carry()
/// @self obj_player
function scr_player_carry()
{
	gml_pragma("forceinline");
	
	/// @method _attach_to_tails()
	var _attach_to_tails = function(_who, _tails)
	{
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
	
	if (vd_player_type != PLAYER.TAILS)
	{
		exit;
	}

	if (carry_cooldown > 0)
	{
		carry_cooldown--;
		exit;
	}

	if (carry_target == noone)
	{
		if (action != ACTION.FLIGHT)
		{
			exit;
		}

		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			if (_p == player_index)
			{
				continue;
			}
		
			var _player = player_get(_p);
		
			if (_player.action == ACTION.SPINDASH || _player.action == ACTION.CARRIED || _player.state >= PLAYERSTATE.NO_CONTROL)
			{
				continue;
			}
		
			var _dist_x = floor(_player.x) - floor(x);
			var _dist_y = floor(_player.y) - floor(y);
		
			if (abs(_dist_x) < 16 && abs(_dist_y) - 32 < 16)
			{
				_player.reset_state();		
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
		clear_carry();
	}
	else if (carry_target.input_press.action_any)
	{
		carry_target = noone;
		carry_cooldown = 18;
		
		with (carry_target)
		{
			is_jumping = true;
			action = ACTION.NONE;
			animation = ANIM.SPIN;
			radius_x = radius_x_spin;
			radius_y = radius_y_spin;
			vel_y = jump_min_vel;
			
			if (input_down.left)
			{
				vel_x = -2;
			}
			else if (input_down.right)
			{
				vel_x = 2;
			}
		}
		
		audio_play_sfx(snd_jump);
	}
	else if floor(carry_target.x) != floor(carry_target_x) || floor(carry_target.y) != floor(carry_target_y)
	{
		clear_carry();
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