/// @method destroy()
destroy = function()
{
	instance_destroy();
}

// Inherit the parent event
event_inherited();

depth -= 1;