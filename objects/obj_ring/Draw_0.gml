if (vd_state != RINGSTATE.DROP)
{
	sprite_animate(obj_framework.frame_counter, 6);
}

// Inherit the parent event
event_inherited();