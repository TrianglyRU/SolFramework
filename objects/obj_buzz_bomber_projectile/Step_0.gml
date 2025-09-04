if !visible
{
	if --wait_timer < 0
	{
		visible = true;
		m_animation_start(sprite_index, 0, 1, 8);
	}
}
else if sprite_index != spr_badnik_projectile
{
	if image_timer < 0
	{
		m_animation_start(spr_badnik_projectile, 0, 0, 2);
	}
}
else
{
	// Inherit the parent event
	event_inherited();
}