function game_get_state_name()
{
	switch obj_game.state
	{
		case GAME_STATE.NORMAL: return "NORMAL";
		case GAME_STATE.PAUSED: return "PAUSED";
		case GAME_STATE.STOP_OBJECTS: return "STPOBJ";
		default: return "UNKNOWN";
	}
}