// Inherit the parent event
event_inherited();

depth = RENDER_DEPTH_HUD;
allowed_game_state = GAME_STATE.PAUSED;
shader_surface = array_create(CAMERA_COUNT, -1);
timer = 0;
offset_zone = 288;
offset_zonename = 256;
offset_act = 320;
offset_banner = -224;
speed_x = 16;
speed_y = 16;

if global.stage_transition_data != undefined
{
	for (var _i = 0; _i < CAMERA_COUNT; _i++)
	{
		camera_toggle_movement(_i, false);
	}
}
else
{
	fade_perform_black(FADE_DIRECTION.OUT, 0);
}