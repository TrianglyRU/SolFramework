#region METHODS

/// @method set_velocity()
set_velocity = function()
{
	vel_x = spd_ground * dcos(angle);
	vel_y = spd_ground * -dsin(angle);
}

/// @method respawn()
respawn = function()
{
	scr_player_init();
	
	if (player_index > 0)
	{
		x = 127;
		y = 0;
		depth = RENDERER_DEPTH_HIGHEST + player_index;	
		cpu_state = CPUSTATE.RESPAWN_INIT;
		state = PLAYERSTATE.NO_CONTROL;
		is_grounded = false;
	}
	else
	{
		camera_data.allow_movement = true;
		state = PLAYERSTATE.RESPAWN;
	}
}

/// @method reset_state()
reset_state = function()
{
	switch (action)
	{
		case ACTION.DASH:
			audio_stop_sound(snd_charge2);
		break;

		case ACTION.FLIGHT:
			audio_stop_sound(snd_flight);
			audio_stop_sound(snd_flight2);
		break;
	}
	
	action = ACTION.NONE;
	shield_state = SHIELDSTATE.NONE;
	is_jumping = false;
	is_grounded = false;
	forced_roll = false;
	on_object = noone;
	set_push_anim_by = noone;
	radius_x = radius_x_normal;
	radius_y = radius_y_normal;
	visual_angle = 0;
	
	clear_carry();
}

/// @method reset_gravity()
reset_gravity = function()
{
	grv = is_underwater ? PARAM_GRV_UNDERWATER : PARAM_GRV_DEFAULT;
}

/// @method release_glide()
release_glide = function(_frame)
{
	glide_value = _frame;			// glide_value is the start frame of ANIM.GLIDE_FALL
	animation = ANIM.GLIDE_FALL;
	action = ACTION.GLIDE;
	action_state = GLIDESTATE.FALL;
	radius_x = radius_x_normal;
	radius_y = radius_y_normal;
	
	reset_gravity();
}

/// @method land()
land = function()
{
	reset_gravity();
	
	is_grounded = true;

	if (action == ACTION.SPINDASH || action == ACTION.DASH || action == ACTION.HAMMERDASH)
	{
		if (action == ACTION.DASH)
		{
			spd_ground = dash_vel;
		}

		exit;
	}
	
	if (shield == SHIELD.BUBBLE && shield_state == SHIELDSTATE.ACTIVE)
	{
		var _force = is_underwater ? -4 : -7.5;
		vel_y = _force * dcos(angle);
		vel_x = _force * dsin(angle);
		shield_state = SHIELDSTATE.NONE;
		on_object = noone;
		is_grounded = false;
		
		audio_play_sfx(snd_shield_bubble2);
		
		with (obj_shield)
		{
			if (vd_target_player == other.id)
			{
				obj_set_anim(spr_shield_bubble_bounce, 6, [0, 0, 1], function(){ set_bubble_shield_animation(); });
			}
		}
		
		exit;
	}

	if (state == PLAYERSTATE.HURT)
	{
		spd_ground = 0;
	}
	
	animation = ANIM.MOVE;
	state = PLAYERSTATE.CONTROL;
	cpu_state = CPUSTATE.MAIN;
	shield_state = SHIELDSTATE.NONE;
	air_lock_flag = false;
	is_jumping = false;
	set_push_anim_by = noone;
	score_combo = 0;
	tile_behaviour = TILEBEHAVIOUR.DEFAULT;
	visual_angle = angle > 22.5 && angle < 337.5 ? angle : 0;
	
	clear_carry();
	
	scr_player_dropdash();
	scr_player_hammerspin();
	
	if (action != ACTION.HAMMERDASH)
	{
		action = ACTION.NONE;
	}
	
	if (animation != ANIM.SPIN)
	{
		var _diff = radius_y_normal - radius_y;
		radius_x = radius_x_normal;
		radius_y = radius_y_normal;
		
		y = angle > 90 && angle <= 270 ? y + _diff : y - _diff;
	}
}

/// @method add_score()
add_score = function(_score_combo)
{
	if (_score_combo < 4)
	{
		global.score_count += score_values[_score_combo]; 
	}
	else
	{
		global.score_count += score_values[_score_combo < 16 ? 4 : 5];
	}
}

/// @method is_invincible
is_invincible = function()
{
	return inv_frames > 0 || item_inv_timer > 0 || super_timer > 0 || shield_state == SHIELDSTATE.DOUBLESPIN;
}

/// @method hurt()
hurt = function(_sound = snd_hurt, _hazard = other)
{
	if (state != PLAYERSTATE.CONTROL || is_invincible())
	{
		return;
	}
	
	var _is_shielded_player1 = player_index == 0 && shield == SHIELD.NONE;

	if (_is_shielded_player1 && global.player_rings == 0)
	{
		kill(_sound);
		exit;
	}
	
	reset_state();
	
	vel_x = floor(x) < floor(_hazard.x) ? -2 : 2;
	vel_y = -4;
	animation = ANIM.HURT;
	state = PLAYERSTATE.HURT;
	spd_ground = 0;
	grv = 0.1875;
	air_lock_flag = true;
	inv_frames = 120;

	if (is_underwater)
	{
		vel_x *= 0.5;
		vel_y *= 0.5;
		grv -= 0.15625;
	}

	if (_is_shielded_player1)
	{
		var _ring_direction = -1;
		var _ring_angle = 101.25;
		var _ring_speed = 4;
		var _count = min(global.player_rings, 32);

		for (var _i = 0; _i < _count; _i++) 
		{
			instance_create(x, y, obj_ring,
			{
				vd_state: RINGSTATE.DROP,			
				vd_vel_x: _ring_speed * dcos(_ring_angle) * -_ring_direction,
				vd_vel_y: _ring_speed * -dsin(_ring_angle)
			});

			if (_ring_direction == 1)
			{
				_ring_angle += 22.5;
			}
			
			if (_i == 15)
			{
				_ring_speed = 2;
				_ring_angle = 101.25;
			}
			
			_ring_direction *= -1;
		}
		
		global.player_rings = 0;
		global.ring_spill_counter = 256;
		global.life_rewards[0] = RINGS_THRESHOLD;
		
		audio_play_sfx(snd_ring_loss);
	}
	else
	{
		shield = SHIELD.NONE;
		audio_play_sfx(_sound);
	}

	return;
}

/// @method kill()
kill = function(_sound = snd_hurt)
{
	if (state == PLAYERSTATE.DEATH)
	{
		exit;
	}

	audio_play_sfx(_sound);
	reset_state();

	if (player_index == 0)
	{
		obj_framework.state = FWSTATE.STOP_OBJECTS;
	}
	
	depth = RENDERER_DEPTH_HIGHEST + player_index;
	action = ACTION.NONE;
	animation = ANIM.DEATH;
	state = PLAYERSTATE.DEATH;
	grv = 0.21875;
	vel_y = -7;
	vel_x = 0;
	spd_ground = 0;
	
	if (camera_data.index == player_index)
	{
		camera_data.allow_movement = false;
	}
}

/// @method set_camera_delay()
set_camera_delay = function(_delay)
{
	if (!global.cd_camera && camera_data.target == noone && camera_data.index == player_index)
	{
		camera_data.delay_x = _delay;
	}
}

/// @method clear_carry()
clear_carry = function()
{
	if (carry_target != noone)
	{
		carry_target.action = ACTION.NONE;
		carry_target = noone;
		carry_cooldown = 60;
	}
}

/// @method record_data()
record_data = function(_insert_pos)
{
	if (_insert_pos >= ds_record_length)
	{
		exit;
	}

	var _data =
	[
		struct_copy(input_press), struct_copy(input_down), floor(x), floor(y), set_push_anim_by, facing
	];
	
	ds_list_insert(ds_record_data, _insert_pos, _data);
	ds_list_delete(ds_record_data, ds_record_length);
}

/// @method play_tails_sound()
play_tails_sound = function()
{
	if ((obj_framework.frame_counter + 8) % 16 != 0 || is_underwater || !obj_is_visible())
	{
		exit;
	}

	if (cpu_state != CPUSTATE.RESPAWN)
	{
		audio_play_sfx(flight_timer > 0 ? snd_flight : snd_flight2);
	}
	else if (global.cpu_behaviour == CPUBEHAVIOUR.S3)
	{
		audio_play_sfx(snd_flight);
	}
}

/// @method get_flip_order_data()
get_flip_order_data = function()
{
	if (animation == ANIM.FLIP_EXTENDED)
	{
		animation = ANIM.FLIP;
		
		// TODO: LTS'24: array_concat
		return
		[
			0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3,
			3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6,
			6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 11, 11, 11, 0, 0,
			0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3,
			3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6,
			6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 11, 11, 11, 0, 0
		];
	}
	
	return
	[
		0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3,
		3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6,
		6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 11, 11, 11, 0, 0
	];
}

#endregion

#region ENUM & MACRO

enum PLAYER
{
	SONIC = 0,
	TAILS = 1,
	KNUCKLES = 2,
	AMY = 3,
	NONE = 255
}

enum PLAYERSTATE
{
	CONTROL,
	HURT,
	DEATH,
	NO_CONTROL,
	DEBUG_MODE,
	RESPAWN
}

enum CPUSTATE
{
	MAIN,
	STUCK,
	RESPAWN_INIT,
	RESPAWN
}

enum CPUBEHAVIOUR
{
	S2,
	S3
}

enum PHYSICS
{
	S1,
	CD,
	S2,
	S3,
	SK
}

enum ACTION
{
	NONE,
	SPINDASH,
	DASH,
	DROPDASH,
	GLIDE,
	CLIMB,
	FLIGHT,
	TRANSFORM,
	HAMMERDASH,
	HAMMERSPIN,
	CARRIED
}

enum GLIDESTATE
{
	AIR,
	GROUND,
	FALL
}

enum CLIMBSTATE
{
	NORMAL,
	LEDGE
}

enum DEATHSTATE
{
	WAIT,
	RESTART
}

enum SHIELD
{
	NONE,
	NORMAL,
	LIGHTNING,
	FIRE,
	BUBBLE
}

enum SHIELDSTATE
{
	NONE,
	ACTIVE,
	DISABLED,
	DOUBLESPIN
}

enum ANIM
{
	IDLE,
	WAIT,
	MOVE,
	SPIN,
	SPINDASH,
	PUSH,
	DUCK,
	LOOKUP,
	GRAB,
	HURT,
	DEATH,
	DROWN,
	SKID,
	TRANSFORM,
	BREATHE,
	BOUNCE,
	FLIP,
	FLIP_EXTENDED,
	HAMMERDASH,
	BALANCE,
	BALANCE_FLIP,
	BALANCE_PANIC,
	BALANCE_TURN,
	FLY,
	FLY_TIRED,
	SWIM,
	SWIM_TIRED,
	SWIM_CARRY,
	GLIDE_AIR,
	GLIDE_GROUND,
	GLIDE_FALL,
	GLIDE_LAND,
	CLIMB_WALL,
	CLIMB_LEDGE
}

#macro PLAYER_COUNT instance_number(obj_player)
#macro PLAYER_MAX_COUNT 8
#macro AIR_TIMER_DEFAULT 1800
#macro PARAM_GRV_DEFAULT 0.21875
#macro PARAM_GRV_UNDERWATER 0.0625
#macro PARAM_GRV_TAILS_UP -0.125
#macro PARAM_GRV_TAILS_DOWN 0.03125
#macro PARAM_DROPDASH_CHARGE 22
#macro PARAM_DASH_CHARGE 30
#macro PARAM_SKID_SPEED_THRESHOLD 4
#macro PARAM_RECORD_LENGTH 32
#macro PARAM_CPU_DELAY 16

#endregion

// Inherit the parent event
event_inherited();

obj_set_priority(2);
obj_set_culling(CULLING.PAUSEONLY);

scr_player_init();
scr_player_debug_mode_init();