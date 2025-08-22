/// @method load_bonus_stage()
load_bonus_stage = function()
{
	room_goto(rm_bonus);
}

// Inherit the parent event
event_inherited();

obj_set_hitbox(4, 4);
obj_set_anim(sprite_index, 2, 0, 0);

transition_flag = false;
timer = 0;
radius = 0;
depth -= 2;