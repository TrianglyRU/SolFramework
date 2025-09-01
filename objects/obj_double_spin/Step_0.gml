if (!instance_exists(vd_target_player))
{
	instance_destroy();
}
else if (--attack_timer <= 0)
{
	if (vd_target_player.shield_state == SHIELD_STATE.DOUBLE_SPIN)
	{
		vd_target_player.shield_state = SHIELD_STATE.DISABLED;
	}
	
	instance_destroy();
}