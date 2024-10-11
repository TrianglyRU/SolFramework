/// @self
/// @description Sets the palette index for the given colour indexes and optionally stops their rotation.
/// @param {Array<Real>} _colour_indexes An array of colour indexes to modify.
/// @param {Real} _index The new palette index.
/// @param {Bool} [_stop_rotation] Whether to stop the rotation (default is false).
function pal_set_index(_colour_indexes, _index, _stop_rotation = false)
{
	with (obj_framework)
	{
		for (var _i = array_length(_colour_indexes) - 1; _i >= 0; _i--)
		{
			var _colour_index = _colour_indexes[_i];
			
			if !_stop_rotation
			{
				palette_timers[_colour_index] = palette_durations[_colour_index];
				palette_indexes[_colour_index] = _index;
			}
			else
			{
				palette_durations[_colour_index] = 0;
			}
		}
	}
}