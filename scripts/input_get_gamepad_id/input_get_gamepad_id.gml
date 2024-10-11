/// @self
/// @description Retrieves the gamepad ID associated with the specified input slot.
/// @param {Real} _slot The input slot number.
/// @returns {Real|Undefined}
function input_get_gamepad_id(_slot)
{
	return obj_framework.input_list_gamepads[| _slot];
}