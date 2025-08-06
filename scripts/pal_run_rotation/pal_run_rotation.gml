/// @self
/// @description Rotates the palette colours of the given indices.
/// @param {Array<Real>} _colour_indices An array of colour indices to rotate.
/// @param {Real} _duration The duration per one palette index, in game steps.
/// @param {Real} _loop_index The palette index to loop back to.
/// @param {Real} _end_index The ending palette index.
function pal_run_rotation(_colour_indices, _duration, _loop_index, _end_index)
{
	var _timers = obj_game.palette_timers;
	var _durations = obj_game.palette_durations;
	var _loop_indices = obj_game.palette_loop_indices;
	var _end_indices = obj_game.palette_end_indices;
	var _rotations = obj_game.palette_rotations;
	
	for (var _i = array_length(_colour_indices) - 1; _i >= 0; _i--)
	{
		var _index = _colour_indices[_i];
		if (_index < PALETTE_TOTAL_SLOT_COUNT)
		{
			if (_durations[_index] != _duration)
			{
				_timers[_index] = _duration;
			}
			
			_loop_indices[_index] = _loop_index;
			_end_indices[_index] = _end_index;
			_durations[_index] = _duration;
			
			ds_list_add(_rotations, _index);
		}
	}
}