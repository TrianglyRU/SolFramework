/// @self
/// @description Retrieves the palette index for a given colour index.
/// @param {Real} _colour_index The colour index.
/// @returns {Real}
function pal_get_index(_colour_index)
{
	return obj_framework.palette_indexes[_colour_index];
}