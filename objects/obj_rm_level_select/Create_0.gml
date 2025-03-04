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

/// @method is_regular_entry()
is_regular_entry = function(_entry_index)
{
	return string_char_at(level_entries[_entry_index], 1) != "/";
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
	"TEST STAGE|1",
	"|2",
	"|3",
	"/",
	"ZONEENTRY|1",
	"|2",
	"/",
	"ZONEENTRY|1",
	"|2",
	"/",
	"ZONEENTRY|1",
	"|2",
	"/",
	"ZONEENTRY|1",
	"|2",
	"/",
	"ZONEENTRY|1",
	"|2",
	"/",
	"ZONEENTRY|1",
	"|2",
	"/n",
	"ZONEENTRY|1",
	"|2",
	"/p",
	"/",
	"ZONEENTRY|1",
	"|2",
	"/",
	"SPECIAL STAGE",
	"/",
	"/",
	"BONUS STAGE",
	"/",
	"/",
	"SOUND TEST"
];

level_rediretions =
[
	0,  rm_stage_tsz0,
	1,  rm_stage_tsz1,
	2,  rm_stage_tsz2,
	29, rm_special,
	32, rm_bonus
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

update_stage_selection();
fade_perform_black(FADEROUTINE.IN, 1);
audio_play_bgm(snd_bgm_level_select);
discord_set_data("LEVEL SELECT", "", "room_levels", "");