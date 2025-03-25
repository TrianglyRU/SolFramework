/// @self
/// @description Sets the "local" palette index for the given colour indices.
/// @param {Array<Real>} _colour_indices An array of colour indices to modify.
/// @param {Real} _replacement_index The new palette index.
function pal_set_index_local(_colour_indices, _replacement_index)
{
	with (obj_framework)
	{
		for (var _i = array_length(_colour_indices) - 1; _i >= 0; _i--)
		{
			var _index = _colour_indices[_i] + PALETTE_GLOBAL_SLOT_COUNT;
			
			if (_index < PALETTE_TOTAL_SLOT_COUNT)
			{
				palette_timers[_index] = palette_durations[_index];
				palette_indices[_index] = _replacement_index;
			}	
		}
	}
}