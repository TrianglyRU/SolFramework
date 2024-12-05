if (room == rm_startup)
{
	return;
}

with (obj_instance)
{
	event_perform(ev_other, ev_user11);
	event_perform(ev_other, ev_user12);
}

#region AUDIO

audio_emitter_gain(audio_emitter_sfx, global.sound_volume);

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	var _state = audio_channel_states[_i];
    var _bgm = audio_channel_bgms[_i];
	
    if (_bgm == -1)
    {
        continue;
    }
	
    audio_emitter_gain(audio_emitter_bgm[_i], global.music_volume);
	
    if (audio_sound_length(_bgm) == -1 || _state == CHANNELSTATE.STOP && audio_sound_get_gain(_bgm) == 0)
    {
		audio_channel_states[_i] = CHANNELSTATE.DEFAULT;
		audio_channel_bgms[_i] = -1;
		
		audio_stop_sound(_bgm);
		
        continue;
    }
	
    if (_i == AUDIO_CHANNEL_JINGLE)
    {
        continue;
    }
	
	var _bgm_asset = asset_get_index(audio_get_name(_bgm));
	var _loop_data = ds_map_find_value(global.looped_audio_data, _bgm_asset);
	
	if (_loop_data != undefined)
	{
		var _bgm_pos = audio_sound_get_track_position(_bgm);
		
		if (_bgm_pos >= _loop_data[1] - 0.01)
		{
			audio_sound_set_track_position(_bgm, _loop_data[0]);
		}
	}
	
    var _jingle_bgm = audio_channel_bgms[AUDIO_CHANNEL_JINGLE];
	
    if (_jingle_bgm != -1)
    {
        if _state != CHANNELSTATE.MUTE
        {
            audio_channel_states[_i] = CHANNELSTATE.TEMPMUTE;
        }
		
        audio_mute_bgm(0.0, _i);
    }
    else if (_state == CHANNELSTATE.TEMPMUTE)
    {
        audio_unmute_bgm(1.0, _i);
    }
}

#endregion

#region BACKGROUND

if (state != FWSTATE.PAUSED && bg_layer_count > 0)
{
    for (var _i = 0; _i < bg_layer_count; _i++)
    {
		var _parallax_data = bg_parallax_data[_i];
		
        _parallax_data.scroll_x += _parallax_data.scroll_vel_x;
        _parallax_data.scroll_y += _parallax_data.scroll_vel_y;
    }
}

#endregion

#region CAMERA

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
    var _camera_data = camera_get_data(_i);
	
    if (_camera_data == undefined)
    {
        continue;
    }
	
	// Doing so in a Draw Event will result in a "blank" frame
	if (!surface_exists(view_surface_id[_i]))
    {
		// Draw views to their surfaces
		view_surface_id[_i] = surface_create(_camera_data.surface_w, _camera_data.surface_h);
		
		surface_set_target(view_surface_id[_i]);
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
    }
	
	if (state != FWSTATE.PAUSED && _camera_data.allow_movement)
	{
		var _target = _camera_data.target;
		
		// Built-in object tracking system. The player object uses its own
	    if (_target != noone)
	    {
			instance_activate_object(_target);
			
			if (instance_exists(_target))
			{
		        var _width = camera_get_width(_i);
		        var _height = camera_get_height(_i);
		        var _target_x = _target.x - _camera_data.pos_x - _width / 2;
		        var _target_y = _target.y - _camera_data.pos_y - _height / 2 + 16;
			
				var _freespace_x = 16;
				var _freespace_y = 32;
				var _max_vel = 32;
			
		        if (_target_x > 0)
		        {
		            _camera_data.vel_x = min(_target_x, _max_vel);
		        }
		        else if (_target_x < -_freespace_x)
		        {
		            _camera_data.vel_x = max(_target_x + _freespace_x, -_max_vel);
		        }
		        else
		        {
		            _camera_data.vel_x = 0;
		        }
			 
		        if (_target_y > _freespace_y)
		        {
		            _camera_data.vel_y = min(_target_y - _freespace_y, _max_vel);
		        }
		        else if (_target_y < -_freespace_y)
		        {
		            _camera_data.vel_y = max(_target_y + _freespace_y, -_max_vel);
		        }
		        else
		        {
		            _camera_data.vel_y = 0;
		        }
		    }
		    else
		    {
		        _camera_data.target = noone;
		    }
		}
		
	    if (_camera_data.shake_timer > 0)
	    {
	        if (_camera_data.shake_offset == 0)
	        {
	            _camera_data.shake_offset = _camera_data.shake_timer;
	        }
	        else if (_camera_data.shake_offset < 0)
	        {
	            _camera_data.shake_offset = -1 - _camera_data.shake_offset;
	        }
	        else
	        {
	            _camera_data.shake_offset = -_camera_data.shake_offset;
	        }

	        _camera_data.shake_timer--;
	    }
	    else
	    {
	        _camera_data.shake_offset = 0;
	    }
		
	    if (_camera_data.delay_x == 0)
	    {
	        _camera_data.pos_x_prev = _camera_data.pos_x;
	        _camera_data.pos_x += _camera_data.vel_x;
	    }
	    else if (_camera_data.delay_x > 0)
	    {
	        _camera_data.delay_x--;
	    }

	    if (_camera_data.delay_y == 0)
	    {
	        _camera_data.pos_y_prev = _camera_data.pos_y;
	        _camera_data.pos_y += _camera_data.vel_y;
	    }
	    else if (_camera_data.delay_y > 0)
	    {
	        _camera_data.delay_y--;
	    }
	}
	
	var _x = clamp(floor(_camera_data.pos_x + _camera_data.offset_x), _camera_data.bound_left, _camera_data.bound_right - camera_get_width(_i)) + _camera_data.shake_offset;
    var _y = clamp(floor(_camera_data.pos_y + _camera_data.offset_y), _camera_data.bound_upper, _camera_data.bound_lower - camera_get_height(_i)) + _camera_data.shake_offset;
	
    camera_set_view_pos(view_camera[_i], _x - CAMERA_HORIZONTAL_BUFFER, _y);
}

#endregion

#region CULLING

/// @feather ignore GM2016
cull_restore_paused();

with (obj_instance)
{
	event_perform(ev_other, ev_user15);
}

#endregion

#region DISTORTION

if (state != FWSTATE.PAUSED)
{
    for (var _i = 0; _i < 2; _i++)
    {
        var _effect = distortion_effects[_i];
		
        if (_effect != -1)
        {
			distortion_offsets[_i] -= distortion_speeds[_i];
        }
    }
}

#endregion

#region GAMEPLAY

if (state != FWSTATE.PAUSED)
{
    if (global.ring_spill_counter > 0)
    {
        global.ring_spill_counter--;
    }
	
    var _ring_count = global.player_rings;
    var _score_count = global.score_count;
	var _life_count = global.life_count;
	
    if (_ring_count >= global.life_rewards[0] && global.life_rewards[0] <= 200)
    {
        global.life_rewards[0] += RINGS_THRESHOLD;
		global.life_count++;
    }
	
    if (_score_count >= global.life_rewards[1])
    {
        global.life_rewards[1] += SCORE_THRESHOLD;
		global.life_count++;
    }
	
	if (_life_count != global.life_count)
	{
		audio_play_bgm(snd_bgm_extralife, AUDIO_CHANNEL_JINGLE);
	}
}

#endregion

#region SPRITE ANIMATOR

var _is_enabled = state != FWSTATE.PAUSED;

if (sprite_update_enabled != _is_enabled)
{
    for (var _i = array_length(sprite_array) - 2; _i >= 0; _i -= 2)
    {
		/// @feather ignore GM1044
        sprite_set_speed(sprite_array[_i], _is_enabled ? (1 / sprite_array[_i + 1]) : 0, spritespeed_framespergameframe);
    }

    sprite_update_enabled = _is_enabled;
}

#endregion