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

if global.stage_transition_data == undefined
{
	fade_perform_black(FADE_DIRECTION.OUT, 0);
}