/// @self
/// @description					Checks if saved data exists for the specified slot.
/// @param {Real|Undefined} _slot	The slot index to check for saved data.
/// @returns {Bool}
function game_check_data(_slot)
{
	if _slot == undefined
	{
		return false;
	}
	
	return file_exists("save" + string(_slot) + ".bin");
}