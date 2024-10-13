/// @self
/// @description Sets the "global" palette index for the given colour indices and optionally stops their rotation.
/// @param {Array<Real>} _colour_indices An array of colour indices to modify.
/// @param {Real} _replacement_index The new palette index.
/// @param {Bool} [_stop_rotation] Whether to stop the rotation (default is false).
function pal_set_index(_colour_indices, _replacement_index, _stop_rotation = false)
{
	with (obj_framework)
	{
		for (var _i = array_length(_colour_indices) - 1; _i >= 0; _i--)
		{
			var _index = _colour_indices[_i];
			
			if (_index >= PALETTE_GLOBAL_SLOT_COUNT)
			{
				continue;
			}
			
			if (!_stop_rotation)
			{
				palette_timers[_index] = palette_durations[_index];
				palette_indices[_index] = _replacement_index;
			}
			else
			{
				palette_durations[_index] = 0;
			}
		}
	}
}