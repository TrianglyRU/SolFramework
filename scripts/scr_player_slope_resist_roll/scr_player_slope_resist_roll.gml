/// @self obj_player
function scr_player_slope_resist_roll()
{
	if angle < 135 || angle >= 225
	{
		spd_ground -= (sign(spd_ground) == sign(dsin(angle)) ? 0.078125 : 0.3125) * dsin(angle);
	}
}