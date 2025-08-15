/// @self obj_game
/// @function scr_game_setup()
function scr_game_setup()
{
	// Change the rm_startup's size to set up the game's default
	// internal (application_surface) and camera resolution

	global.dev_mode = true;
	global.window_name = "GameMaker - Orbinaut Framework"
	global.start_fullscreen = true;
	global.window_scale = 2;
	global.gamepad_rumble = false;
	global.music_volume = 0.5;
	global.sound_volume = 0.5;
	global.start_room = rm_branding;
	global.discord_ready = np_initdiscord("1286956015241265174", true, 0);
	
	global.player_physics = PHYSICS.S3;
	global.cpu_behaviour = CPUBEHAVIOUR.S3;
	global.rotation_mode = ROTATION.MANIA;
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
	global.better_solid_collision = true;
	global.better_angle_snap = true;
	
	game_font_register(spr_font_large, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
	game_font_register(spr_font_large_alt, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
	game_font_register(spr_font_small, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:!-+_", false, 0);
	game_font_register(spr_font_digits, "0123456789:';", false, 1);
	game_font_register(spr_font_digits_alt, "0123456789:';", false, 1);
	game_font_register(spr_font_digits_small, "0123456789", false, 1);
	game_font_register(spr_font_system, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.:,;'(!?)+-*=_[]{}<>|#$%&^@~/", false, 0);
	
	#region AUDIO LOOPS
	
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
	
	#endregion
	
	#region COLLISION DATA
	
	// Default collision
	var _default_angle_data =
	[
			 0,   240, 240, 248, 248, 248, 248, 254, 248, 246, 246, 246, 246, 248, 254,
		0,   254, 252, 248, 246, 244, 246, 242, 238, 238, 240, 240, 244, 248, 252, 252,
		254, 246, 246, 240, 234, 230, 224, 220, 216, 208, 202, 202, 194, 196, 202, 206,
		210, 216, 224, 224, 234, 238, 242, 248, 254, 224, 210, 212, 212, 234, 236, 250,
		210, 192, 192, 208, 216, 216, 244, 236, 222, 212, 204
	];
	
	tile_calculate_data(spr_collision_default, _default_angle_data, 16);
	
	// Delta World collision
	tile_calculate_data(spr_collision_dwz, undefined, 16);
	tile_alter_angle(spr_collision_dwz, 2, 11.25);
	tile_alter_angle(spr_collision_dwz, 3, 11.25);
	tile_alter_angle(spr_collision_dwz, 104, 18.28);
	tile_alter_angle(spr_collision_dwz, 105, 35.15625);
	
	// Sonic 1 collision
	var _s1_angle_data =
	[
			 0,   136, 144, 160, 176, 184, 196, 0,   0,   0,   0,   208, 0,   0,   0,    
		252, 252, 252, 252, 252, 252, 252, 252, 248, 248, 248, 248, 240, 240, 208, 208, 
		212, 224, 224, 200, 252, 248, 240, 234, 230, 224, 224, 236, 204, 240, 200, 200, 
		218, 214, 200, 208, 216, 232, 4,   240, 208, 196, 122, 108, 106, 244, 84,  0,  
		16,  20,  22,  24,  24,  24,  28,  28,  32,  36,  44,  40,  88,  88,  0,   0,  
		224, 34,  96,  84,  32,  0,   32,  0,   248, 248, 248, 248, 28,  20,  8,   8,
		6,   4,   2,   0,   252, 252, 252, 248, 244, 240, 236, 232, 224, 188, 180, 180, 
		160, 148, 140, 132, 16,  0,   0,   0,   4,   4,   212, 212, 4,   6,   8,   12, 
		14,  12,  20,  16,  12,  12,  8,   6,   4,   4,   120, 108, 96,  84,  72,  0,   
		0,   068, 112, 88,  0,   228, 208, 208, 4,   208, 16,  36,  56,  0,   0,   16, 
		32,  48,  12,  20,  32,  44,  52,  124, 112, 88,  72,  132, 136, 144, 152, 156, 
		160, 176, 184, 188, 40,  24,  32,  232, 244, 32,  24,  128, 128, 132, 136, 136, 
		140, 144, 148, 148, 140, 140, 136, 132, 132, 128, 128, 140, 144, 152, 168, 168, 
		176, 184, 192, 8,   24,  48,  132, 136, 144, 152, 168, 176, 180, 184, 188, 16, 
		32,  48,  8,   10,  12,  16,  228, 236, 228, 232, 232, 232, 244, 216, 236, 244, 
		250, 252, 56,  56,  56,  56,  228, 0
	]
	
	tile_calculate_data(spr_collision_s1, _s1_angle_data, 16);
	
	// Sonic 2 collision
	var _s2_angle_data =
	[
			 0,   224, 208, 208, 200, 200, 200, 200, 240, 240, 248, 248, 248, 248, 0, 
		252, 248, 244, 240, 232, 228, 226, 224, 0,   212, 208, 208, 200, 198, 196, 252, 
		240, 232, 224, 216, 208, 196, 252, 248, 244, 240, 236, 232, 228, 226, 224, 226,
		228, 232, 232, 236, 240, 244, 246, 248, 252, 254, 0,   254, 252, 250, 248, 246, 
		244, 242, 242, 244, 246, 248, 250, 252, 254, 252, 248, 240, 232, 224, 216, 212, 
		208, 200, 196, 248, 224, 200, 196, 204, 212, 224, 236, 244, 252, 196, 200, 204, 
		208, 216, 224, 228, 232, 240, 244, 248, 252, 208, 224, 240, 252, 248, 240, 232,
		228, 224, 220, 196, 200, 208, 216, 24,  16,  16,  32,  37,  40,  32,  32,  36, 
		216, 208, 240, 248, 254, 248, 240, 224, 208, 200, 196, 224, 228, 220, 216, 208, 
		204, 200, 198, 196, 254, 252, 252, 248, 240, 232, 228, 244, 224, 220, 212, 252, 
		244, 224, 246, 246, 0,   0,   0,   252, 252, 0,   0,   252, 240, 240, 0,   220, 
		224, 246, 248, 240, 240, 240, 232, 252, 244, 252, 232, 216, 0,   220, 220, 252, 
		240, 252, 252, 208, 0,   32,  224, 252, 248, 240, 240, 240, 248, 252, 252, 248, 
		252, 254, 248, 240, 32,  208, 204, 194, 228, 228, 228, 228, 0
	]
	
	tile_calculate_data(spr_collision_s2, _s2_angle_data, 16);
	
	// Sonic 3K collision
	var _s3_angle_data =
	[
			 0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
		252, 252, 252, 252, 252, 252, 252, 252, 248, 248, 248, 0,   240, 240, 226, 208, 
		208, 200, 200, 200, 200, 200, 212, 214, 214, 222, 222, 0,   250, 238, 232, 242, 
		242, 240, 252, 252, 250, 248, 246, 246, 248, 250, 252, 252, 242, 244, 244, 226, 
		228, 240, 238, 254, 252, 248, 244, 244, 240, 244, 248, 252, 252, 236, 236, 224,
		228, 220, 242, 246, 250, 252, 232, 236, 224, 212, 208, 202, 198, 194, 236, 244,
		252, 214, 224, 204, 196, 212, 216, 224, 212, 240, 236, 236, 110, 114, 120, 0, 
		96,  100, 0,   92,  236, 244, 252, 132, 140, 146, 160, 168, 10,  32,  178, 56, 
		188, 70,  194, 84,  202, 112, 106, 96,  210, 108, 112, 224, 190, 180, 168, 160, 
		152, 140, 132, 216, 226, 232, 242, 246, 250, 0,   254, 250, 248, 242, 224, 238, 
		246, 252, 224, 224, 252, 246, 238, 196, 202, 210, 210, 202, 196, 62,  56,  52, 
		48,  48,  52,  58,  62,  0,   40,  40,  40,  40,  40,  168, 168, 168, 168, 168, 
		104, 112, 120, 124, 126, 96,  96,  80,  72,  72,  68,  66,  40,  40,  40,  32, 
		24,  24,  16,  12,  8,   4,   244, 244, 250, 252, 238, 238, 242, 224, 232, 224, 
		232, 254, 238, 236, 254, 252, 248, 52,  224, 224, 196, 204, 224, 212, 252, 244, 
		236, 0,   0,   0,   250, 250, 244, 240, 224, 0
	]
	
	tile_calculate_data(spr_collision_s3, _s3_angle_data, 16);
	
	#endregion
}