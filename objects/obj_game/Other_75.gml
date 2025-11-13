// Feather ignore GM1041

/// @description Gamepad Detection
var _connected_index = async_get("gamepad discovered", "pad_index");

if _connected_index != undefined
{
	ds_list_add(global.gamepad_list, _connected_index);
	gamepad_set_axis_deadzone(_connected_index, INPUT_GAMEPAD_DEADZONE);
	
	show_debug_message("[INFO] " + gamepad_get_description(_connected_index) + " (" + string(_connected_index) + ")" + " has been registered into slot " + string(ds_list_size(global.gamepad_list)));
}
else 
{
	var _lost_index = async_get("gamepad lost", "pad_index");
	
	if _lost_index != undefined
	{
		var _pos = ds_list_find_index(global.gamepad_list, _lost_index);
	
		if _pos != -1
		{
			ds_list_delete(global.gamepad_list, _pos);
		
			show_debug_message("[INFO] Gamepad " + string(_lost_index) + " has been removed from slot " + string(_pos));
		}
	}
}