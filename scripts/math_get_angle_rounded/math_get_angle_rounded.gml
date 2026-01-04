/// @self
/// @description			Rounds an angle in degrees to the nearest raw angle value.
/// @param {Real} _angle	The angle in degrees to round.
/// @returns {Real}
function math_get_angle_rounded(_angle)
{
	return round(_angle / ANGLE_INCREMENT) * ANGLE_INCREMENT;
}