/// @function scr_player_hammerdash()
/// @self obj_player
function scr_player_hammerdash()
{
	gml_pragma("forceinline");
	
	if (action != ACTION.HAMMERDASH)
	{
		return;
	}
	
	if (spd_ground == 0 && hammerdash_timer > 0 || ++hammerdash_timer == 60 || !input_down.action_any || dcos(angle) <= 0 || set_push_anim_by != noone)
	{
		action = ACTION.NONE;
		return;
	}
	
	if (input_press.left && facing == DIRECTION.POSITIVE || input_press.right && facing == DIRECTION.NEGATIVE)
	{
		facing *= -1;
	}
	
	if (is_grounded)
	{
		spd_ground = 6 * facing;
		set_velocity();
	}
}