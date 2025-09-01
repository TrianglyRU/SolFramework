enum OUTSIDE_ACTION
{
	PAUSE,
	RESPAWN,
	DESTROY
}

dependent_from = noone;
ignore_object_stop = false;

sprite_index_start = sprite_index;
image_xscale_start = image_xscale;
image_yscale_start = image_yscale;
image_index_start = image_index;
depth_start = depth;
visible_start = visible;

sprite_play_count = 0;
image_duration = 0;
image_timer = 0;
image_loopback = 0;

outside_respawned = false; 
outside_action = OUTSIDE_ACTION.PAUSE;