var _frame = floor(obj_game.frame_counter * 0.5);
var _last_frame = array_length(bg_playback_data);
	
with obj_layer
{
	image_index = other.bg_playback_data[_frame % _last_frame];
}

down_cooldown++;

var _total_entries = array_length(level_entries);
var _input_press = input_get_pressed(0);
var _input_down = input_get(0);
var _down_update = down_cooldown >= 12;
var _direction = 0;

if _input_press.down || (_input_down.down && _down_update)
{
    _direction = 1;
}
else if _input_press.up || (_input_down.up && _down_update)
{
    _direction = -1;
}

// Up / Down
if _direction != 0
{
    do
    {
        global.selected_level_entry = (global.selected_level_entry + _direction + _total_entries) % _total_entries;
    }
    until is_string_entry(global.selected_level_entry);
    
    set_rooto_load();
}

if level_entries[global.selected_level_entry] == "SOUND TEST"
{
    if _input_press.start
    {
        audio_stop_bgm(1);
        fade_perform_black(FADE_DIRECTION.OUT, 1);
    }
    else if _input_press.left
    {
        global.selected_sound_index = max(0, global.selected_sound_index - 1);
    }
    else if _input_press.right
    {
        global.selected_sound_index = (global.selected_sound_index + 1) % 256;
    }
    else if _input_press.action1
    {
        global.selected_sound_index = (global.selected_sound_index + 16) % 256;
    }
    else if _input_press.action3
    {
		// Register the input
        cheat_code_string = string_concat(cheat_code_string, dec_to_hex(global.selected_sound_index));
		
        for (var _i = 0; _i < array_length(cheat_codes); _i++)
        {
            var _cheat = cheat_codes[_i];
            
            if string_ends_with(cheat_code_string, _cheat.code)
            {
				_cheat.execute();
				cheat_code_string = "";
				
                break;
            }
        }
		
		// Play the sound
		var _sound_id = sound_ids[global.selected_sound_index];
		
		if _sound_id != -1
		{
			var _sound_name = audio_get_name(_sound_id);
			
			if string_starts_with(_sound_name, "snd_bgm_m")
	        {
	            audio_play_bgm(_sound_id, string_ends_with(_sound_name, "extralife") ? AUDIO_CHANNEL_JINGLE : 0);
	        }
	        else
	        {
	            audio_play_sfx(_sound_id);
	        }  
		}		
    }
}

// Left / Right
else if _input_press.left || _input_press.right
{
	var _prev_page_last = 0;
	var _this_page_current = 0;
	var _current_index = global.selected_level_entry;
	
	for (var _i = _current_index; _i >= 0; _i--)
	{
		if level_entries[_i] == "/n"
		{
			_this_page_current = _current_index - _i - 1;
			_prev_page_last = _i - 1;
			
			break;
		}
		
		if _i == 0
		{
			_this_page_current = _current_index - _i;
			_prev_page_last = _total_entries - 1;
		}
	}
	
	if _input_press.left
	{
		var _prev_page_first = _prev_page_last;	
		
		while _prev_page_first > 0 && level_entries[_prev_page_first - 1] != "/n"
		{
			_prev_page_first--;
		}
		
		var _new_index = min(_prev_page_last, _prev_page_first + _this_page_current);
		
		while _new_index > 0 && !is_string_entry(_new_index)
		{
			_new_index--;
		}
		
		global.selected_level_entry = _new_index;
	}
	else if _input_press.right
	{
		var _next_page_first = _current_index + 1;
		
		while _next_page_first != 0 && level_entries[_next_page_first - 1] != "/n"
		{
			_next_page_first = (_next_page_first + 1) % _total_entries;
		}
		
		var _next_page_last = _next_page_first;
		
		while _next_page_last < _total_entries - 1 && level_entries[_next_page_last + 1] != "/n"
		{
			_next_page_last++;
		}
		
		var _new_index = min(_next_page_first + _this_page_current, _next_page_last);
		
		while !is_string_entry(_new_index)
		{
			_new_index--;
		}
		
		global.selected_level_entry = _new_index;
	}
	
	set_rooto_load();
}
else if _input_press.action1 || _input_press.start
{
    if rooto_load != -1
    {
        if rooto_load == rm_special
        {
            audio_play_sfx(snd_warp);
            fade_perform_white(FADE_DIRECTION.OUT, 1);
        }
        else
        {
            fade_perform_black(FADE_DIRECTION.OUT, 1);
        }
		
		audio_stop_bgm(1);
    }
    else
    {
        audio_play_sfx(snd_fail);
    }
}
else if _input_press.action3
{
    global.selected_player_index = (global.selected_player_index + 1) % (PLAYER.AMY + 2);
}