/// @self obj_game_object
/// @description Resets the animation to the first frame and restarts the animation timer.
function obj_restart_anim()
{
	image_index = 0;
	anim_timer = anim_duration;
}