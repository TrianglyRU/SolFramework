/// @self obj_game
/// @function scr_game_setup()
function scr_game_setup()
{
	// Change the rm_startup's size to set up the game's default
	// internal (application_surface) and camera resolution

	global.dev_mode = true;
	
	global.window_name = "GameMaker - Sol Framework"
	global.start_fullscreen = true;
	global.window_scale = 2;
	global.gamepad_rumble = false;
	global.music_volume = 0.5;
	global.sound_volume = 0.5;
	global.start_room = rm_branding;
	global.discord_ready = np_initdiscord("1286956015241265174", true, 0);
	
	global.player_physics = PHYSICS.S2;
	global.cpu_behaviour = CPUBEHAVIOUR.S3;
	global.rotation_mode = ROTATION.CLASSIC;
	global.rotation_range = RANGE.DEFAULT;
	global.spin_dash = true;
	global.dash	= true;
	global.drop_dash = false;
	global.double_spin = false;
	global.cd_timer = false;
	global.cd_camera = false;
	global.roll_lock = true;
	global.speed_cap = false;
	global.roll_speed_cap = true;
	
	global.better_solid_collision = false;
	global.better_angle_snap = true;
	
	global.tools_binary_collision = false;
	
	game_font_register(spr_font_large, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
	game_font_register(spr_font_large_alt, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
	game_font_register(spr_font_small, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:!-+_", false, 0);
	game_font_register(spr_font_digits, "0123456789:';", false, 1);
	game_font_register(spr_font_digits_alt, "0123456789:';", false, 1);
	game_font_register(spr_font_digits_small, "0123456789", false, 1);
	game_font_register(spr_font_system, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.:,;'(!?)+-*=_[]{}<>|#$%&^@~/", false, 0);
	
	audio_set_bgm_loop(snd_bgm_bonus, 10.85, 39.85);
	audio_set_bgm_loop(snd_bgm_invincibility, 0.00, 10.30);
	audio_set_bgm_loop(snd_bgm_highspeed, 1.40, 27.37);
	audio_set_bgm_loop(snd_bgm_continue, 1.40, 11.15);
	audio_set_bgm_loop(snd_bgm_super, 0.40, 67.60);
	audio_set_bgm_loop(snd_bgm_special, 1.71, 51.21);
	audio_set_bgm_loop(snd_bgm_boss, 19.40, 83.20);
	audio_set_bgm_loop(snd_bgm_ghz, 14.80, 53.20);
	audio_set_bgm_loop(snd_bgm_ehz, 3.47, 44.94);
	audio_set_bgm_loop(snd_bgm_dwz, 12.88, 123.15);
	audio_set_bgm_loop(snd_bgm_level_select, 0.92, 60.65);
	
	/* Collision data */
	
	// Default
	var _default_angle_data =
	[
			 0,   240, 240, 248, 248, 248, 248, 254, 248, 246, 246, 246, 246, 248, 254,
		0,   254, 252, 248, 246, 244, 246, 242, 238, 238, 240, 240, 244, 248, 252, 252,
		254, 246, 246, 240, 234, 230, 224, 220, 216, 208, 202, 202, 194, 196, 202, 206,
		210, 216, 224, 224, 234, 238, 242, 248, 254, 224, 210, 210, 6,   20,  22,  44,
		44,  64,  192, 48,  88,  88,  244, 236, 222, 212, 204
	];
	
	tile_calculate_data(spr_collision_default, _default_angle_data, 0, 0, 2, 2, 16);
	
	// Delta World
	tile_calculate_data(spr_collision_dwz, undefined, 0, 0, 2, 2, 16);
	tile_alter_angle(spr_collision_dwz, 2, 11.25);
	tile_alter_angle(spr_collision_dwz, 3, 11.25);
	tile_alter_angle(spr_collision_dwz, 104, 270);
	tile_alter_angle(spr_collision_dwz, 105, 35.15625);
}