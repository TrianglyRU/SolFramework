/// @self
/// @description Loads the configuration file ("config.ini").
/// @returns {Bool}
function game_load_settings()
{
	ini_open("config.ini");
	
	global.gamepad_rumble = ini_read_real("INPUT", "gamepadRumble", global.gamepad_rumble);
	global.music_volume = ini_read_real("AUDIO", "bgmVolume", global.music_volume);
	global.sound_volume = ini_read_real("AUDIO", "sfxVolume", global.sound_volume);
	global.window_scale = ini_read_real("VIDEO", "windowScale", global.window_scale);
	
	ini_close();
}