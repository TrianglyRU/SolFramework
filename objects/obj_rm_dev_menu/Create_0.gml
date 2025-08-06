#region METHODS

/// @method add_category()
add_category = function(_title, _entry_array)
{
	// previous category_id, stored option_id, title
    var _data = [0, 0, _title];
	
    for (var _i = 0; _i < array_length(_entry_array); _i++)
    {
        array_push(_data, _entry_array[_i]);
    }
	
    ds_map_add(all_categories_data, categories_count, _data);
	
    categories_count++;
}

/// @method load_category()
load_category = function(_new_category_id)
{
	var _new_data = all_categories_data[? _new_category_id];
	var _current_data = all_categories_data[? category_id];
	
	if (_new_category_id == _current_data[0])
	{
	    _current_data[1] = 0;
	    option_id = _new_data[1];
	}
	else
	{
	    _new_data[0] = category_id;
	    _current_data[1] = option_id;
	    option_id = 0;
	}
    
	category_id = _new_category_id;
	category_data = _new_data;
    category_options_count = array_length(_new_data) - 3;
	
    if (_new_category_id == 3)
    {
        for (var _i = 0; _i < category_options_count; _i++)
        {
            alter_setting(_i);
        }
    } 
}

/// @method alter_option()
alter_option = function(_id, _string)
{
    category_data[_id + 3] = _string;
}

/// @method alter_setting()
alter_setting = function(_setting_id)
{
    alter_option(_setting_id, string_split(category_data[_setting_id + 3], ":")[0] + get_setting(_setting_id));
}

/// @method get_setting()
get_setting = function(_id)
{
	var _display = "GET_SETTING() NOT SET";
    switch (_id)
    {
        case 0: 
			_display = global.gamepad_rumble ? "TRUE" : "FALSE";
		break;
		
        case 1:
			_display = string(round(global.music_volume * 100)) + "%";
		break;
		
        case 2:
			_display = string(round(global.sound_volume * 100)) + "%";
		break;
		
        case 3: 
			_display = string(global.window_scale) + "X";
		break;
		
		case 4:
			_display = window_get_fullscreen() ? "TRUE" : "FALSE";
		break;
    }
	
	return ": " + _display;
}

#endregion

all_categories_data = ds_map_create();
category_data = [];	
categories_count = 0;
category_id = 0;
category_options_count = 0;
option_id = 0;
room_to_load = -1;

add_category    // ID 0
(
    "ORBINAUT FRAMEWORK DEV MENU\n(Sol Version)",
    [
		"START GAME",
		"ROOM SELECT",
		"SETTINGS",
		"CLOSE GAME"
	]
);

add_category    // ID 1
(
    "START GAME\nPress action 3 to delete a save file",
	[
	    "NO SAVE",
	    "SAVE 0",
	    "SAVE 1",
	    "SAVE 2",
	    "SAVE 3"
	]
);

// Automatically generate room list
var _room_list = [];
for (var _i = 1; _i <= room_last; _i++)
{
	_room_list[_i - 1] = string_upper(room_get_name(_i));
}

add_category    // ID 2
(
    "ROOM SELECT", _room_list
);

add_category    // ID 3
(
    "SETTINGS",
	[
	    "GAMEPAD RUMBLE",
	    "BGM VOLUME",
	    "SFX VOLUME",
	    "WINDOW SCALE",
	    "FULLSCREEN"
	]
);

add_category    // ID 4
(
    "PLAYER 1 SELECT",
	[
	    "SONIC",
	    "TAILS",
	    "KNUCKLES",
	    "AMY"
	]
);

add_category    // ID 5
(
    "PLAYER 2 SELECT",
	[
	    "SONIC",
	    "TAILS",
	    "KNUCKLES",
	    "AMY",
	    "NO PLAYER 2"
	]
);

load_category(0);
discord_set_data("In Menus", "", "", "");