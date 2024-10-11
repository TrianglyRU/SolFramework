/// @function scr_framework_setup()
/// @self obj_framework
function scr_framework_setup()
{
	global.dev_mode = true;
	
	global.window_name = "GameMaker - Sol Framework"
	global.init_resolution_w = 400;
	global.init_resolution_h = 224;
	global.window_scale = 2;
	global.use_vsync = true;
	global.gamepad_rumble = false;
	global.music_volume = 0.5;
	global.sound_volume = 0.5;
	global.start_room = rm_devmenu;
	global.discord_ready = np_initdiscord("1286956015241265174", true, 0);
	
	global.player_physics = PHYSICS.S2;
	global.cpu_behaviour = CPUBEHAVIOUR.S3;
	global.rotation_mode = ROTATION.CLASSIC;
	global.spin_dash = true;
	global.dash	= true;
	global.drop_dash = true;
	global.double_spin = false;
	global.cd_timer = false;
	global.cd_camera = false;
	global.roll_lock = true;
	global.speed_cap = false;
	global.better_solid_collision = false;

	global.gfx_enabled = true;
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
	audio_set_bgm_loop(snd_bgm_aiz, 0.00, 65.54);
}