// Inherit the parent event
event_inherited();
event_animator();

#region MACRO & ENUM

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

enum PLAYER_STATE
{
	DEFAULT,
	HURT,
	DEFAULT_LOCKED,
	DEBUG_MODE,
	DEATH,
	RESPAWN
}

enum CPU_STATE
{
	MAIN,
	STUCK,
	RESPAWN_INIT,
	RESPAWN
}

enum CPU_BEHAVIOUR
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

enum GLIDE_STATE
{
	AIR,
	GROUND,
	FALL
}

enum CLIMB_STATE
{
	NORMAL,
	LEDGE
}

enum DEATH_STATE
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

enum SHIELD_STATE
{
	NONE,
	ACTIVE,
	DISABLED,
	DOUBLE_SPIN
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

#endregion

#region METHODS

set_velocity = function()
{
	vel_x = spd_ground * dcos(angle);
	vel_y = spd_ground * -dsin(angle);
}

set_hitbox = function(_hbleft, _hbtop, _hbright, _hbbottom)
{
	hbox_left = _hbleft;
	hbox_top = _hbtop;
	hbox_right = _hbright;
	hbox_bottom = _hbbottom;
}

set_extra_hitbox = function(_hbleft, _hbtop, _hbright, _hbbottom)
{
	hbox_ext_left = _hbleft;
	hbox_ext_top = _hbtop;
	hbox_ext_right = _hbright;
	hbox_ext_bottom = _hbbottom;
}

respawn = function()
{
	scr_player_init();
	
	if player_index > 0
	{
		x = 127;
		y = 0;
		visible = false;
		depth = RENDER_DEPTH_PRIORITY + player_index;	
		cpu_state = CPU_STATE.RESPAWN_INIT;
		state = PLAYER_STATE.DEFAULT_LOCKED;
		is_grounded = false;
	}
	else
	{
		camera_data.allow_movement = true;
		state = PLAYER_STATE.RESPAWN;
	}
}

reset_substate = function()
{
	switch action
	{
		case ACTION.DASH:
			audio_stop_sound(snd_charge_dash);
		break;

		case ACTION.FLIGHT:
		
			audio_stop_sound(snd_flight);
			audio_stop_sound(snd_flight_2);
			
		break;
	}
	
	// Clear actions
	action = ACTION.NONE;
	shield_state = SHIELD_STATE.NONE;
	is_jumping = false;
	set_push_anim_by = noone;
	is_water_running = false;
	clear_carry();
	
	// Clear collision
	is_grounded = false;
	on_object = noone;
	solid_radius_x = radius_x_normal;
	solid_radius_y = radius_y_normal;
	
	reset_gravity();
	visual_angle = 0;
}

reset_gravity = function()
{
	grv = is_underwater ? PARAM_GRV_UNDERWATER : PARAM_GRV_DEFAULT;
}

release_glide = function(_frame)
{
	glide_value = _frame;			// glide_value is the start frame of ANIM.GLIDE_FALL
	animation = ANIM.GLIDE_FALL;
	action = ACTION.GLIDE;
	action_state = GLIDE_STATE.FALL;
	solid_radius_x = radius_x_normal;
	solid_radius_y = radius_y_normal;
	reset_gravity();
}

land = function()
{
	is_grounded = true;
	reset_gravity();
	
	if action == ACTION.SPINDASH || action == ACTION.DASH || action == ACTION.HAMMERDASH
	{
		if action == ACTION.DASH
		{
			spd_ground = dash_vel;
		}
		
		return;
	}
	
	var _shield = global.player_shields[player_index];
	
	if _shield == SHIELD.BUBBLE && shield_state == SHIELD_STATE.ACTIVE
	{
		var _force = is_underwater ? -4 : -7.5;
		
		vel_y = _force * dcos(angle);
		vel_x = _force * dsin(angle);
		shield_state = SHIELD_STATE.NONE;
		on_object = noone;
		is_grounded = false;
		
		audio_play_sfx(snd_shield_bubble_2);
		
		with obj_shield
		{
			if player == other.id
			{
				bubble_shield_bounce_animation();
			}
		}
		
		return;
	}

	if state == PLAYER_STATE.HURT
	{
		spd_ground = 0;
	}
	
	state = PLAYER_STATE.DEFAULT;
	cpu_state = CPU_STATE.MAIN;
	shield_state = SHIELD_STATE.NONE;
	air_lock_flag = false;
	is_jumping = false;
	set_push_anim_by = noone;
	score_combo = 0;
	visual_angle = angle > 22.5 && angle < 337.5 ? angle : 0;
	
	if !is_water_running
	{
		animation = ANIM.MOVE;
	}
	
	clear_carry();
	
	// Handle is_grounded routines of some actions
	scr_player_dropdash();
	scr_player_hammerspin();
	
	if action != ACTION.HAMMERDASH
	{
		action = ACTION.NONE;
	}
	
	if animation != ANIM.SPIN
	{
		y += (radius_y_normal - solid_radius_y) * (angle > 90 && angle <= 270 ? 1 : -1);
		solid_radius_x = radius_x_normal;
		solid_radius_y = radius_y_normal;
	}
}

add_score = function(_score_combo)
{
	if _score_combo < 4
	{
		global.score_count += score_values[_score_combo]; 
	}
	else
	{
		global.score_count += score_values[_score_combo < 16 ? 4 : 5];
	}
}

is_invincible = function()
{
	return inv_frames > 0 || item_inv_timer > 0 || super_timer > 0 || shield_state == SHIELD_STATE.DOUBLE_SPIN;
}

hurt = function(_sound = snd_hurt, _hazard = other)
{
	if state != PLAYER_STATE.DEFAULT || is_invincible()
	{
		return;
	}
	
	var _is_not_shielded_player1 = player_index == 0 && global.player_shields[0] == SHIELD.NONE;
	
	if _is_not_shielded_player1 && global.player_rings == 0
	{
		kill(_sound);
		return;
	}
	
	reset_substate();
	vel_x = floor(x) < floor(_hazard.x) ? -2 : 2;
	vel_y = -4;
	animation = ANIM.HURT;
	state = PLAYER_STATE.HURT;
	spd_ground = 0;
	grv = 0.1875;
	air_lock_flag = true;
	inv_frames = 120;
	
	if is_underwater
	{
		vel_x *= 0.5;
		vel_y *= 0.5;
		grv -= 0.15625;
	}
	
	if _is_not_shielded_player1
	{
		var _ring_direction = -1;
		var _ring_angle = 101.25;
		var _ring_speed = 4;
		var _count = min(global.player_rings, 32);

		for (var _i = 0; _i < _count; _i++) 
		{
			with instance_create(x, y, obj_ring)
			{
				depth = draw_depth(30);
				culler.action = CULL_ACTION.DESTROY;
				state = RING_STATE.DROPPED;
				vel_x = _ring_speed * dcos(_ring_angle) * -_ring_direction;
				vel_y = _ring_speed * -dsin(_ring_angle);
			}
			
			if _ring_direction == 1
			{
				_ring_angle += 22.5;
			}
			
			if _i == 15
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
		audio_play_sfx(_sound);
		global.player_shields[player_index] = SHIELD.NONE;
	}
}

kill = function(_sound = snd_hurt)
{
	if state == PLAYER_STATE.DEATH
	{
		return;
	}
	
	if player_index == 0
	{
		obj_game.state = GAME_STATE.STOP_OBJECTS;
	}
	
	audio_play_sfx(_sound);
	
	reset_substate();
	animation = ANIM.DEATH;
	state = PLAYER_STATE.DEATH;
	grv = 0.21875;
	vel_y = -7;
	vel_x = 0;
	spd_ground = 0;
	depth = RENDER_DEPTH_PRIORITY + player_index;
	
	if camera_data.index == player_index
	{
		camera_data.allow_movement = false;
	}
}

set_camera_delay = function(_delay)
{
	if !global.cd_camera && camera_data.target == noone && camera_data.index == player_index
	{
		camera_data.delay_x = _delay;
	}
}

clear_carry = function()
{
	if carry_target != noone
	{
		carry_target.action = ACTION.NONE;
		carry_target = noone;
		carry_cooldown = 60;
	}
}

record_data = function(_insert_pos)
{
	if _insert_pos >= ds_record_length
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

play_tails_sound = function()
{
	if (obj_game.frame_counter + 8) % 16 != 0 || is_underwater || !instance_is_drawn()
	{
		return;
	}
	
	if cpu_state != CPU_STATE.RESPAWN
	{
		audio_play_sfx(flight_timer > 0 ? snd_flight : snd_flight_2);
	}
	else if global.cpu_behaviour == CPU_BEHAVIOUR.S3
	{
		audio_play_sfx(snd_flight);
	}
}

is_true_glide = function()
{
	return action == ACTION.GLIDE && action_state != GLIDE_STATE.FALL;
}

clear_solid_push = function(_inst_id = other.id)
{
	if set_push_anim_by == _inst_id
	{
		if animation != ANIM.SPIN && animation != ANIM.SPINDASH
		{
			animation = ANIM.MOVE;
		}
		
		set_push_anim_by = noone;
	}
}

restart_bgm = function(_default_bgm)
{
	if super_timer > 0
    {
        audio_play_bgm(snd_bgm_super);
    }
    else if item_inv_timer > 0
    {
        audio_play_bgm(snd_bgm_invincibility);
    }
    else if item_speed_timer > 0
    {
        audio_play_bgm(snd_bgm_highspeed);
    }
    else
    {
		
        audio_play_bgm(_default_bgm);
    }
}

press_action_any = function()
{
	return input_press.action1 || input_press.action2 || input_press.action3;
}

down_action_any = function()
{
	return input_down.action1 || input_down.action2 || input_down.action3;
}

#endregion

allowed_game_state = GAME_STATE.STOP_OBJECTS;
obj_game.player_count++;

scr_player_init();
scr_player_debug_mode_init();