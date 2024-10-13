/// @self
/// @description Retrieves the palette index for a given colour index from the "local" palette.
/// @param {Real} _colour_index The colour index.
/// @returns {Real}
function pal_get_index_local(_colour_index)
{
	var _index = _colour_index + PALETTE_GLOBAL_SLOT_COUNT;
			
	if (_index >= PALETTE_TOTAL_SLOT_COUNT)
	{
		_index = PALETTE_TOTAL_SLOT_COUNT - 1;
	}
			
	return obj_framework.palette_indices[_index];
}