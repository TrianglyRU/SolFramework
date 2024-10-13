/// @self
/// @description Rotates the "local" palette colours of the given indices.
/// @param {Array<Real>} _colour_indices An array of colour indices to rotate.
/// @param {Real} _duration The duration per one palette index, in game steps.
/// @param {Real} _loop_index The palette index to loop back to.
/// @param {Real} _end_index The ending palette index.
function pal_run_rotation_local(_colour_indices, _duration, _loop_index, _end_index)
{
	with (obj_framework)
	{
		for (var _i = array_length(_colour_indices) - 1; _i >= 0; _i--)
		{
			var _index = _colour_indices[_i] + PALETTE_GLOBAL_SLOT_COUNT;
			
			if (_index >= PALETTE_TOTAL_SLOT_COUNT)
			{
				continue;
			}
			
			ds_list_add(palette_colours, _index);
			
			if (palette_durations[_index] != _duration)
			{
				palette_timers[_index] = _duration;
			}

			palette_loop_indices[_index] = _loop_index;
			palette_end_indices[_index] = _end_index;
			palette_durations[_index] = _duration;
		}
	}
}