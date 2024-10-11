if (!obj_is_visible())
{ 
	instance_destroy();
}
else
{
	// Inherit the parent event
	event_inherited();
}