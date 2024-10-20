/// @method _spawn_debris
var _spawn_debris = function(_side = 0)
{
	for (var _i = 0; _i < array_length(debris_pos_table); _i += 2)
	{
		var _vel_x = debris_vel_table[_i];
		var _vel_y = debris_vel_table[_i + 1];
		var _sign_x = _side == SOLIDCOLLISION.LEFT ? 1 : -1;
		
		if (vd_type == ROCKTYPE.BREAKABLE_SIDES && sign(_vel_x) != _sign_x)
		{
			_vel_x *= -1;
		}
				
		instance_create(x + debris_pos_table[_i], y + debris_pos_table[_i + 1], obj_rock_aiz_debris, 
		{
			vd_vel_x: _vel_x, vd_vel_y: _vel_y, image_index: _i / 2
		});
	}
}

switch (vd_type)
{
	case ROCKTYPE.FULL_SOLID:
	
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			obj_act_solid(player_get(_p), SOLIDOBJECT.FULL);
		}
	
	break;
	
	case ROCKTYPE.BREAKABLE_SIDES:
		
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			var _player = player_get(_p);
			var _smash_vel = _player.vel_x;
			
			obj_act_solid(_player, SOLIDOBJECT.FULL);
			
			if not (_player.animation == ANIM.SPIN && _player.is_grounded && abs(_smash_vel) >= 4
			  || _player.vd_player_type == PLAYER.KNUCKLES
			  || _player.action == ACTION.HAMMERSPIN
			  || _player.animation == ANIM.HAMMERDASH
			  || _player.shield == SHIELD.FIRE && _player.shield_state == SHIELDSTATE.ACTIVE
			  || _player.super_timer > 0)
			{
				continue;
			}
			
			var _side = floor(_player.x) < floor(x) ? SOLIDCOLLISION.LEFT : SOLIDCOLLISION.RIGHT;

			if (!obj_check_solid(_player, _side))
			{
				continue;
			}
			
			with (_player)
			{
				if (action == ACTION.GLIDE && action_state == GLIDESTATE.AIR)
				{
					release_glide(0);
				}
				
				x -= 4 * sign(_smash_vel);
				vel_x = _smash_vel;
				spd_ground = vel_x;
				set_push_anim_by = noone;
			}
			
			_spawn_debris(_side);
			audio_play_sfx(snd_break_block);
			instance_destroy();

			break;
		}
	
	break;
	
	case ROCKTYPE.BREAKABLE_TOP:
		
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			var _player = player_get(_p);
			var _is_spinning = _player.animation == ANIM.SPIN;
			
			obj_act_solid(_player, SOLIDOBJECT.FULL, _is_spinning ? SOLIDATTACH.NONE : SOLIDATTACH.DEFAULT);
			
			if (!_is_spinning || !obj_check_solid(_player, SOLIDCOLLISION.TOP))
			{
				continue;
			}
			
			_player.vel_y = -3;
			
			with (obj_player) 
			{
				if (on_object == other.id)
				{
					is_grounded = false;
					on_object = noone;
				}
			}
			
			_spawn_debris();
			audio_play_sfx(snd_break_block);
			instance_destroy();
			
			break;
		}
		
	break;
	
	case ROCKTYPE.PUSHABLE:
	
		for (var _p = 0; _p < PLAYER_COUNT; _p++)
		{
			var _player = player_get(_p);
			
			obj_act_solid(_player, SOLIDOBJECT.FULL);
			
			// TODO: this is not accurate, invesitage into the disassembly more
			/*
			if (xstart - x > 64 || floor(_player.x) < x || _player.facing != DIRECTION.NEGATIVE)
			{
				continue;
			}
			
			if (obj_check_solid(_player, SOLIDCOLLISION.PUSH))
			{
				if (++push_count % 2 != 0)
				{
					continue;
				}
				
				with (_player)
				{
					spd_ground = 0;
					vel_x = 0;
					x--;
				}
				
				y += tile_find_v(x, y + solid_radius_y, DIRECTION.POSITIVE)[0];
				x--;
			}
			*/
		}
		
	break;
}