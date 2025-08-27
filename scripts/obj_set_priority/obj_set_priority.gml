/// @self g_object
/// @description Adjusts the drawing priority based on the specified priority value from 0 to 8, inclusive.
/// @param {Real} _priority The desired priority level.
function obj_set_priority(_priority)
{
	_priority = clamp(round(_priority) * 10, 0, 80);
	
	if (depth % 100 != 0)
	{
		depth = floor(depth / 100) * 100 + _priority;
	}
	else
	{
		depth += _priority;
	}
	
	cull_depth = depth;
}