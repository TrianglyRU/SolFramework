/// @self obj_game_object
/// @description Resets the animation playback to the first frame, restarts the animation timer and resets the play counter.
function obj_restart_anim()
{
	image_index = 0;
	anim_timer = anim_duration;
	anim_play_count = 0;
}