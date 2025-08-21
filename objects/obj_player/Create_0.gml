/// @feather ignore GM1041
obj_game.player_count++;

#macro PLAYER_COUNT obj_game.player_count
#macro PLAYER_MAX_COUNT 8
#macro AIR_TIMER_DEFAULT 1800
#macro PARAM_GRV_DEFAULT 0.21875
#macro PARAM_GRV_UNDERWATER 0.0625
#macro PARAM_GRV_TAILS_UP -0.125
#macro PARAM_GRV_TAILS_DOWN 0.03125
#macro PARAM_DROPDASH_CHARGE 22
#macro PARAM_SKID_SPEED_THRESHOLD 4
#macro PARAM_RECORD_LENGTH 32
#macro PARAM_CPU_DELAY 16

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
	DEFAULT,
	HURT,
	LOCKED,
	DEBUG_MODE,
	DEATH,
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

enum ROTATION
{
	CLASSIC, MANIA
}

enum RANGE
{
	DEFAULT, SHALLOW
}

/// @method set_velocity()
set_velocity = function()
{
	vel_x = spd_ground * dcos(angle);
	vel_y = spd_ground * -dsin(angle);
}

/// @method set_extra_hitbox()
set_extra_hitbox = function(_radius_x, _radius_y, _offset_x = 0, _offset_y = 0)
{
	ext_hitbox_radius_x = _radius_x;
	ext_hitbox_radius_y = _radius_y;
	ext_hitbox_offset_x = _offset_x;
	ext_hitbox_offset_y = _offset_y;
}

/// @method respawn()
respawn = function()
{
	scr_player_init();
	
	if (player_index > 0)
	{
		x = 127;
		y = 0;
		visible = false;
		depth = RENDERER_DEPTH_HIGHEST + player_index;	
		cpu_state = CPUSTATE.RESPAWN_INIT;
		state = PLAYERSTATE.LOCKED;
		is_grounded = false;
	}
	else
	{
		camera_data.allow_movement = true;
		state = PLAYERSTATE.RESPAWN;
	}
}

/// @method reset_substate()
reset_substate = function()
{
	switch (action)
	{
		case ACTION.DASH:
			audio_stop_sound(snd_charge_dash);
		break;

		case ACTION.FLIGHT:
			audio_stop_sound(snd_flight);
			audio_stop_sound(snd_flight_2);
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
	
	self.clear_carry();
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
	self.reset_gravity();
}

/// @method land()
land = function()
{
	self.reset_gravity();
	is_grounded = true;
	
	if (action == ACTION.SPINDASH || action == ACTION.DASH || action == ACTION.HAMMERDASH)
	{
		if (action == ACTION.DASH)
		{
			spd_ground = dash_vel;
		}

		return;
	}
	
	var _shield = global.player_shields[player_index];
	if (_shield == SHIELD.BUBBLE && shield_state == SHIELDSTATE.ACTIVE)
	{
		var _force = is_underwater ? -4 : -7.5;
		
		vel_y = _force * dcos(angle);
		vel_x = _force * dsin(angle);
		shield_state = SHIELDSTATE.NONE;
		on_object = noone;
		is_grounded = false;
		
		audio_play_sfx(snd_shield_bubble_2);
		
		with (obj_shield)
		{
			if (vd_target_player == other.id)
			{
				obj_set_anim(spr_shield_bubble_bounce, 6, 0, function()
				{ 
					obj_set_anim(spr_shield_bubble, 2, 0, 0); 
				});
			}
		}
		
		return;
	}

	if (state == PLAYERSTATE.HURT)
	{
		spd_ground = 0;
	}
	
	state = PLAYERSTATE.DEFAULT;
	cpu_state = CPUSTATE.MAIN;
	shield_state = SHIELDSTATE.NONE;
	air_lock_flag = false;
	is_jumping = false;
	set_push_anim_by = noone;
	score_combo = 0;
	visual_angle = angle > 22.5 && angle < 337.5 ? angle : 0;
	
	if (!is_water_running)
	{
		animation = ANIM.MOVE;
	}
	
	self.clear_carry();
	
	// Handle actions' is_grounded routines
	scr_player_dropdash();
	scr_player_hammerspin();
	
	if (action != ACTION.HAMMERDASH)
	{
		action = ACTION.NONE;
	}
	
	if (animation != ANIM.SPIN)
	{
		y += (radius_y_normal - radius_y) * (angle > 90 && angle <= 270 ? 1 : -1);
		radius_x = radius_x_normal;
		radius_y = radius_y_normal;
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
	if (state != PLAYERSTATE.DEFAULT || self.is_invincible())
	{
		return;
	}
	
	var _is_not_shielded_player1 = player_index == 0 && global.player_shields[0] == SHIELD.NONE;
	if (_is_not_shielded_player1 && global.player_rings == 0)
	{
		self.kill(_sound);
		return;
	}
	
	self.reset_substate();
	
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

	if (_is_not_shielded_player1)
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
		global.player_shields[player_index] = SHIELD.NONE;
		audio_play_sfx(_sound);
	}
}

/// @method kill()
kill = function(_sound = snd_hurt)
{
	if (state == PLAYERSTATE.DEATH)
	{
		return;
	}
	
	audio_play_sfx(_sound);
	
	if (player_index == 0)
	{
		obj_game.state = GAMESTATE.STOP_OBJECTS;
	}
	
	self.reset_substate();
	action = ACTION.NONE;
	animation = ANIM.DEATH;
	state = PLAYERSTATE.DEATH;
	grv = 0.21875;
	vel_y = -7;
	vel_x = 0;
	spd_ground = 0;
	depth = RENDERER_DEPTH_HIGHEST + player_index;
	
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
		return;
	}

	var _data =
	[
		input_copy(input_press), input_copy(input_down), floor(x), floor(y), set_push_anim_by, facing
	];
	
	ds_list_insert(ds_record_data, _insert_pos, _data);
	ds_list_delete(ds_record_data, ds_record_length);
}

/// @method play_tails_sound()
play_tails_sound = function()
{
	if ((obj_game.frame_counter + 8) % 16 != 0 || is_underwater || !obj_is_visible())
	{
		return;
	}

	if (cpu_state != CPUSTATE.RESPAWN)
	{
		audio_play_sfx(flight_timer > 0 ? snd_flight : snd_flight_2);
	}
	else if (global.cpu_behaviour == CPUBEHAVIOUR.S3)
	{
		audio_play_sfx(snd_flight);
	}
}

/// @method is_not_true_glide()
is_not_true_glide = function()
{
	return action != ACTION.GLIDE || action_state == GLIDESTATE.FALL;
}

/// @method is_true_glide()
is_true_glide = function()
{
	return action == ACTION.GLIDE && action_state != GLIDESTATE.FALL;
}

// Inherit the parent event
event_inherited();

obj_set_priority(2);
obj_set_culling(ACTIVEIF.ENGINE_RUNNING);

scr_player_init();
scr_player_debug_mode_init();