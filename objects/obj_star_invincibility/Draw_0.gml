if (vd_target_player.super_timer <= 0 && vd_target_player.state != PLAYERSTATE.DEATH)
{
	// Inherit the parent event
	event_inherited();
}