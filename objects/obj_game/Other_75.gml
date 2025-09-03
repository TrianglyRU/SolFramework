/// @description Gamepad Detection
var _event = async_load[? "event_type"];
var _pad_index = async_load[? "pad_index"];

if _event == "gamepad discovered"
{
	ds_list_add(global.gamepad_list, _pad_index);
	gamepad_set_axis_deadzone(_pad_index, INPUT_GAMEPAD_DEADZONE);
	
	show_debug_message("[INFO] " + gamepad_get_description(_pad_index) + " (" + string(_pad_index) + ")" + " has been registered into slot " + string(ds_list_size(global.gamepad_list)));
}
else if _event == "gamepad lost"
{
	var _pos = ds_list_find_index(global.gamepad_list, _pad_index);
	
	if _pos != -1
	{
		ds_list_delete(global.gamepad_list, _pos);
		show_debug_message("[INFO] Gamepad " + string(_pad_index) + " has been removed");
	}
}