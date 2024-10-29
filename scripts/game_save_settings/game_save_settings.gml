/// @self
/// @feather ignore GM1041
/// @description Saves settings to the configuration file ("config.ini")
function game_save_settings()
{
	ini_open("config.ini");
	ini_write_real("INPUT", "gamepadRumble", global.gamepad_rumble);
	ini_write_real("AUDIO", "bgmVolume", global.music_volume);
	ini_write_real("AUDIO", "sfxVolume", global.sound_volume);
	ini_write_real("VIDEO", "vSync", global.use_vsync);
	ini_write_real("VIDEO", "windowScale", global.window_scale);
	ini_write_real("VIDEO", "windowMode", window_get_fullscreen());
	ini_close();
	
	instance_create_depth(0, 0, 0, obj_gui_save);
}