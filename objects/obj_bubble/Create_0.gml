#region METHODS

/// @method burst()
burst = function()
{
	obj_set_anim(sprite_index, 6, image_index, function(){ instance_destroy(); });
}

#endregion

enum BUBBLE
{
	SMALL,
	MEDIUM,
	LARGE,
	COUNTDOWN
}

#macro BUBBLE_FINAL_FRAME 5

// Inherit the parent event
event_inherited();

obj_set_priority(1);
obj_set_culling(CULLING.REMOVE);

if (vd_bubble_type == BUBBLE.COUNTDOWN)
{
	obj_set_anim(sprite_index, 6, [0, 1, 1, 2, 3], 4);
}
else
{
	obj_set_anim(sprite_index, 15, 0, 0);
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