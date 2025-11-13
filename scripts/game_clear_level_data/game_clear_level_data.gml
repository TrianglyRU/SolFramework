/// @self
/// @description Clears level-specific data, such as ring count, player shields and life rewards.
/// @param {Bool} [_full_clear] If true, also clears all saved positions and collected giant rings (default is true).
function game_clear_level_data(_full_clear = true)
{
	if _full_clear
	{
		global.checkpoint_data = [];
		global.giant_ring_data = [];
		
		ds_list_clear(global.ds_giant_rings);
	}
	
	for (var _i = array_length(global.player_shields) - 1; _i >= 0; _i--)
	{
		global.player_shields[_i] = SHIELD.NONE;
	}
	
	global.player_rings = 0;
	global.life_rewards =
	[
		RINGS_THRESHOLD, 
		floor(global.score_count / SCORE_THRESHOLD) * SCORE_THRESHOLD + SCORE_THRESHOLD
	];
}