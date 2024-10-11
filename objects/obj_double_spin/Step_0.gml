if (!instance_exists(vd_target_player))
{
	instance_destroy();
}
else if (--attack_timer <= 0)
{
	with (vd_target_player)
	{
		if (shield_state == SHIELDSTATE.DOUBLESPIN)
		{
			shield_state = SHIELDSTATE.DISABLED;
		}
	}
	
	instance_destroy();
}