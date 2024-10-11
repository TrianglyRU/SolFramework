/// @self
/// @description Deletes the saved data for the specified slot.
/// @param {Real} _slot The slot index of the saved data to delete.
function game_delete_data(_slot)
{
	file_delete("save" + string(_slot) + ".bin");
}