/// @self obj_game_object
/// @description Resets and restarts the animation playback from the first frame.
function obj_restart_anim()
{
	image_index = 0;
	anim_timer = anim_duration;
	anim_play_count = 0;
}