/// @self
/// @description Retrieves the gamepad index associated with the specified input slot.
/// @param {Real} _slot The input slot number.
/// @returns {Real|Undefined}
function input_get_gamepad_index(_slot)
{
	return global.gamepad_list[| _slot];
}