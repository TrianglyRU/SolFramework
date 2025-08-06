/// @self
/// @feather ignore GM1045
/// @description Retrieves the current input state (pressed) for the specified slot.
/// @param {Real} _slot The input slot number.
/// @returns {Struct}
function input_get_pressed(_slot)
{
	return obj_game.input_list_press[| _slot];
}