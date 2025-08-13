#region METHODS

/// @method activate()
activate = function()
{
	state = LAMPSTATE.ACTIVE;
	obj_set_anim(sprite_index, 4, 0, 0);
}

#endregion

enum LAMPSTATE
{
	IDLE,
	ROTATE,
	ACTIVE
}

// Inherit the parent event
event_inherited();

state = LAMPSTATE.IDLE;
angle = 0;
radius = floor(sprite_height * 0.5) + 3;
depth -= 1;