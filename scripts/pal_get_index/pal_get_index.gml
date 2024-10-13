/// @self
/// @description Retrieves the palette index for a given colour index from the "global" palette.
/// @param {Real} _colour_index The colour index.
/// @returns {Real}
function pal_get_index(_colour_index)
{
	if (_colour_index >= PALETTE_GLOBAL_SLOT_COUNT)
	{
		return obj_framework.palette_indices[PALETTE_GLOBAL_SLOT_COUNT - 1];
	}
	
	return obj_framework.palette_indices[_colour_index];
}