#region METHODS

/// @method dec_to_hex()
dec_to_hex = function(_number)
{
    var _hex = "";
    var _digits = "0123456789ABCDEF";
    
    if (_number == 0)
	{
        return "00";
    }
	
    while (_number > 0)
	{
        _hex = string_char_at(_digits, _number % 16 + 1) + _hex;
        _number = floor(_number / 16);
    }
	
	if (string_length(_hex) < 2)
	{
	    _hex = "0" + _hex;
	}
	
    return _hex;
}

/// @method get_entry_text_array()
get_entry_text_array = function(_entry_index)
{
	return string_split(level_entries[_entry_index], "|", false);
}

/// @method is_level_entry()
is_level_entry = function(_entry_index)
{
	var _char = string_char_at(string_trim(level_entries[_entry_index]), 1);
	return _char != "/" && _char != "";
}

/// @method update_stage_selection()
update_stage_selection = function()
{
	room_to_load = -1;
	down_cooldown = 0;
	
	for (var _i = 0; _i < array_length(level_rediretions); _i += 2)
	{
		if (global.selected_level_entry == level_rediretions[_i])
		{
			room_to_load = level_rediretions[_i + 1];
			break;
		}
	}
}

#endregion

cheat_code_string = "";
down_cooldown = 0;
room_to_load = -1;
level_entries =
[
	"GREEN HILL|1",
	"		   |2",
	"		   |3",
	"",
	"EMERALD HILL|1",
	"		     |2",
	"",
	"ZONEENTRY|1",
	"		  |2",
	"",
	"ZONEENTRY|1",
	"		  |2",
	"",
	"ZONEENTRY|1",
	"		  |2",
	"",
	"ZONEENTRY|1",
	"		  |2",
	"",
	"ZONEENTRY|1",
	"		  |2",
	"/n",
	"ZONEENTRY|1",
	"		  |2",
	"/p",
	"",
	"ZONEENTRY|1",
	"		  |2",
	"",
	"DELTA WORLD",
	"",
	"",
	"SPECIAL STAGE",
	"",
	"",
	"BONUS STAGE",
	"",
	"",
	"SOUND TEST"
];
level_rediretions =
[
	0,  rm_stage_ghz0,
	4,  rm_stage_ehz0,
	29, rm_stage_dwz0,
	32, rm_special,
	35, rm_bonus
];
bg_playback_data = 
[
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    1, 1, 1, 2, 2, 2,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    2, 2, 2, 1, 1, 1
];
cheat_codes =
[
	{
		code: "04010206",
		execute: function()
		{
			if (global.emerald_count < 7)
			{
			    global.emerald_count = 7;
				audio_play_bgm(snd_bgm_emerald);
			}
		}
	},
	{
		code: "01010204",
		execute: function()
		{
			if (global.continue_count < 14)
			{
			    global.continue_count = 14;
				audio_play_sfx(snd_continue);
			}
		}
	},
	{
		code: "0200020400090007",
		execute: function()
		{
			if (!global.enable_debug_mode)
			{
			    global.enable_debug_mode = true;
				audio_play_sfx(snd_ring_left);
			    audio_play_sfx(snd_ring_right);
			}
		}
	},
];

sound_ids = [];
for (var _i = 0; _i < 256; _i++)
{
	var _sound_name = audio_get_name(_i);
    if (_sound_name == "<undefined>")
    {
        array_push(sound_ids, -1);
    }
	else if (string_starts_with(_sound_name, "snd_bgm"))
	{
		array_insert(sound_ids, 0, _i);
	}
	else
	{
		array_push(sound_ids, _i);
	}
}

update_stage_selection();

audio_play_bgm(snd_bgm_level_select);
bg_convert("Background", 0, 0, 0, 0, 0);
discord_set_data("LEVEL SELECT", "", "room_levels", "");
fade_perform_black(FADEROUTINE.IN, 1);