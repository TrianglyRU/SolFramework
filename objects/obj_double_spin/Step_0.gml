if (!instance_exists(vd_target_player))
{
	instance_destroy();
}
else if (--attack_timer <= 0)
{
	if (vd_target_player.shield_state == SHIELDSTATE.DOUBLESPIN)
	{
		vd_target_player.shield_state = SHIELDSTATE.DISABLED;
	}
	
	instance_destroy();
}