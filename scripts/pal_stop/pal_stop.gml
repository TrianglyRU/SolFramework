/// @self
/// @description Stops the rotation for the given colour indices of the "global" palette.
/// @param {Array<Real>} _colour_indices An array of colour indices stop the rotation for.
function pal_stop(_colour_indices)
{
	for (var _i = array_length(_colour_indices) - 1; _i >= 0; _i--)
	{
		var _index = _colour_indices[_i];
		
		if (_index < PALETTE_GLOBAL_SLOT_COUNT)
		{
			obj_framework.palette_durations[_index] = 0;
		}
	}
}