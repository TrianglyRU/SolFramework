if (sprite_index == -1)
{
	if (--wait_timer < 0)
	{
		obj_set_anim(spr_buzz_bomber_projectile_flare, 8, 0, function()
		{
			obj_set_anim(spr_badnik_projectile, 2, 0, 0);
		});
	}
}
else if (sprite_index == spr_badnik_projectile)
{
	if (cull_parent != noone)
	{
		cull_parent = noone;
	}
	
	// Inherit the parent event
	event_inherited();
}