/// @self obj_player
function scr_player_hammerdash()
{
	if action != ACTION.HAMMERDASH
	{
		return;
	}
	
	if spd == 0 && hammerdash_timer > 0 || ++hammerdash_timer == 60 || dcos(angle) <= 0 || set_push_anim_by != noone || !input_down_action_any()
	{
		action = ACTION.NONE;
	}
	else 
	{
		if input_press.left && facing == 1 || input_press.right && facing == -1
		{
			facing *= -1;
		}
		
		if is_grounded
		{
			spd = acc_top * facing;
			set_velocity();
		}
	}
}