/// @self
/// @description Rotates the "local" palette colours of the given indexes.
/// @param {Array<Real>} _colour_indexes An array of colour indexes to rotate.
/// @param {Real} _duration The duration per one palette index, in game steps.
/// @param {Real} _loop_index The palette index to loop back to.
/// @param {Real} _end_index The ending palette index.
function pal_run_rotation_local(_colour_indexes, _duration, _loop_index, _end_index)
{
	with (obj_framework)
	{
		for (var _i = array_length(_colour_indexes) - 1; _i >= 0; _i--)
		{
			var _index = _colour_indexes[_i] + PALETTE_GLOBAL_SLOT_COUNT;
			
			if (_index >= PALETTE_TOTAL_SLOT_COUNT)
			{
				continue;
			}
			
			ds_list_add(palette_colours, _index);
			
			if (palette_durations[_index] != _duration)
			{
				palette_timers[_index] = _duration;
			}

			palette_loop_indexes[_index] = _loop_index;
			palette_end_indexes[_index] = _end_index;
			palette_durations[_index] = _duration;
		}
	}
}