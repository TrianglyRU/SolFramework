if (vd_bubble_type != BUBBLE.COUNTDOWN && floor(y) < obj_rm_stage.water_level)
{
    if (image_index == image_number - 1)
    {
        burst();
    }
    else
    {
        instance_destroy();
    }
	
    return;
}

wobble_offset = (++wobble_offset) % (array_length(wobble_data) - 1);

x = xstart + wobble_data[wobble_offset] * vd_wobble_direction;
y += vel_y;

if (vd_bubble_type != BUBBLE.COUNTDOWN)
{
    if (image_index == 1 + vd_bubble_type * 2)
    {
        obj_stop_anim();
    }
}
else if (obj_is_anim_ended())
{
    instance_destroy();
    instance_create(x, y, obj_countdown, { image_index: vd_countdown_frame });
	
    return;
}

if (vd_bubble_type != BUBBLE.LARGE || !obj_is_anim_stopped())
{
    return;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
	
    if (_player.state >= PLAYERSTATE.LOCKED || _player.shield == SHIELD.BUBBLE)
    {
        continue;
    }

    var _dist_x = floor(_player.x) - floor(x);
    var _dist_y = floor(_player.y) - floor(y);
    
    if (_dist_x < -16 || _dist_x >= 16 || _dist_y < 0 || _dist_y >= 16)
    {
        continue;
    }
	
	burst();
	
    if (_player.player_index == 0 && audio_is_playing(snd_bgm_drowning))
    {
        audio_reset_bgm(obj_rm_stage.bgm_track, _player);
    }
	
	with (_player)
	{
		if (action != ACTION.FLIGHT && (action != ACTION.GLIDE || action_state == GLIDESTATE.FALL))
	    {
			animation = ANIM.BREATHE;
			reset_substate();
	    }
		
		air_timer = AIR_TIMER_DEFAULT;
	    ground_lock_timer = 35;
	    vel_x = 0;
	    vel_y = 0;
	    spd_ground = 0;
	}
    
    audio_play_sfx(snd_breathe);
	break;
}