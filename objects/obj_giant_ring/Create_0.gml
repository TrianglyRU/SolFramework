enum GIANTRINGSTATE
{
	IDLE,
	ENTRY
}

if (ds_list_find_index(global.ds_giant_rings, id) != -1)
{
	instance_destroy();
	return;
}

/// @method load_special_room()
load_special_room = function()
{
	while (audio_is_playing(snd_warp))
	{
		// Wait until snd_warp is no longer playing
	}
	
	room_goto(rm_special);
}

// Inherit the parent event
event_inherited();

obj_set_priority(3);
obj_set_hitbox(8, 16);
obj_set_culling(ACTIVEIF.INBOUNDS);

state = GIANTRINGSTATE.IDLE;
wait_timer = 32;
image_xscale = 1;