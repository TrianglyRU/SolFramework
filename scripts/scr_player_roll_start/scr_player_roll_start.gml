/// @function scr_player_roll_start()
/// @self obj_player
function scr_player_roll_start()
{
	gml_pragma("forceinline");
	
	if (action == ACTION.SPINDASH || action == ACTION.HAMMERDASH)
	{
	    exit;
	}
	
	if (!forced_roll && (input_down.left || input_down.right))
	{
	    exit;
	}

	var _allowed_to_roll = false;

	if (input_down.down)
	{
	    if (global.player_physics == PHYSICS.SK)
	    {
	        if (abs(spd_ground) >= 1)
	        {
	            _allowed_to_roll = true;
	        }
	        else
	        {
	            animation = ANIM.DUCK;
	        }
	    }
	    else if (abs(spd_ground) >= 0.5)
	    {
	        _allowed_to_roll = true;
	    }
	}
	
	if _allowed_to_roll || forced_roll
	{
		y += radius_y - radius_y_spin;
		radius_x = radius_x_spin;
		radius_y = radius_y_spin;
		animation = ANIM.SPIN;
		
		audio_play_sfx(snd_roll);
	}
}
