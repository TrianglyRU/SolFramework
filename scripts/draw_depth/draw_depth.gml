/// @self
/// @description			Calculates a draw depth aligned to the nearest layer, with a custom priority offset.
/// @param {Real} _priority	The priority offset to add to the floored depth.
/// @returns {Real}
function draw_depth(_priority)
{
	return floor(depth / 100) * 100 + _priority;
}