#macro BUBBLE_FINAL_FRAME 5

enum BUBBLE
{
	SMALL,
	MEDIUM,
	LARGE,
	COUNTDOWN
}

/// @method destroy()
destroy = function()
{
	instance_destroy();
}

/// @method burst()
burst = function()
{
	obj_set_anim(spr_bubble_burst, 6, 0, destroy);
}

// Inherit the parent event
event_inherited();

obj_set_priority(1);
obj_set_culling(ACTIVEIF.INBOUNDS_DELETE);

if (vd_bubble_type == BUBBLE.COUNTDOWN)
{
	obj_set_anim(spr_countdown_bubble, 6, 0, 4);
}
else
{
	obj_set_anim(sprite_index, 15, 0, 5);
}

vel_y = -0.53125;
wobble_offset = 0;
wobble_data =
[
	 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
	 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
	 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2,
	 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
	 0,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-3,-3,-3,-3,-3,
	-3,-3,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,
	-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3,
	-3,-3,-3,-3,-3,-3,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1
];