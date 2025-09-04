var _target_player = image_index > 0 ? image_index - 1 : global.player_main;

if image_index > 0
{
	if global.player_main != _target_player
	{
		return;
	}
}
else
{
	switch _target_player
	{
		case PLAYER.SONIC:
	
			if vd_global_start_sonic
			{
				break;
			}
		
			return;
	
		case PLAYER.TAILS:
	
			if vd_global_start_tails
			{
				break;
			}
		
			return;
		
		case PLAYER.KNUCKLES:
		
			if vd_global_start_knuckles
			{
				break;
			}
		
			return;
		
		case PLAYER.AMY:
	
			if vd_global_start_amy
			{
				break;
			}
		
			return;
	}
}

player_spawn(x, y, _target_player, depth);
instance_destroy();