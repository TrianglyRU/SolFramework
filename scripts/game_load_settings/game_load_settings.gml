/// @self
/// @description Loads the configuration file ("config.ini").
/// @returns {Bool}
function game_load_settings()
{
	ini_open("config.ini");
	
	global.gamepad_rumble = ini_read_real("INPUT", "gamepadRumble", global.gamepad_rumble);
	global.music_volume = ini_read_real("AUDIO", "bgmVolume", global.music_volume);
	global.sound_volume = ini_read_real("AUDIO", "sfxVolume", global.sound_volume);
	global.use_vsync = ini_read_real("VIDEO", "vSync", global.use_vsync);
	global.window_scale = ini_read_real("VIDEO", "windowScale", global.window_scale);
	global.start_fullscreen = ini_read_real("VIDEO", "windowMode", false);
	
	ini_close();
}