/// @function scr_player_palette()
/// @self obj_player
function scr_player_palette()
{
	gml_pragma("forceinline");

	var _colours = [0, 1, 2, 3];
	
	switch (vd_player_type)
	{
	    case PLAYER.TAILS:
	        _colours = [4, 5, 6];
	    break;
		
	    case PLAYER.KNUCKLES:
	        _colours = [7, 8, 9];
	    break;
		
	    case PLAYER.AMY:
	        _colours = [10, 11, 12];
	    break;
	}
	
	var _colour = pal_get_index(_colours[0]);
	var _colour_last = 0;
	var _colour_loop = 0;
	var _duration = 0;
	
	switch (vd_player_type)
	{
	    case PLAYER.SONIC:
		
	        if (_colour < 2)
	        {
	            _duration = 19;
	        }
	        else if (_colour < 7)
	        {
	            _duration = 4;
	        }
	        else
	        {
	            _duration = 8;
	        }
			
	        _colour_last = 16;
	        _colour_loop = 7;
			
	    break;
        
	    case PLAYER.TAILS:
		
	        _duration = _colour < 2 ? 28 : 12;
	        _colour_last = 7;
	        _colour_loop = 2;
			
	    break;
        
	    case PLAYER.KNUCKLES:
		
	        if (_colour < 2)
	        {
	            _duration = 17;
	        }
	        else if (_colour < 3)
	        {
	            _duration = 15;
	        }
	        else
	        {
	            _duration = 3;
	        }
			
	        _colour_last = 11;
	        _colour_loop = 3;
			
	    break;
        
	    case PLAYER.AMY:
		
	        _colour_last = 13;
	        _colour_loop = 2;
	        _duration = _colour < 2 ? 25 : (_colour < _colour_last ? 7 : 12);
			
	    break;
	}

	if (super_timer <= 0)
	{
	    if (_colour > 1)
	    {
	        if (vd_player_type == PLAYER.SONIC)
	        {
	            _colour_last = 21;
	            _duration = 4;
	        }
	    }
	    else
	    {
	        _colour_last = 1;
	        _duration = 0;
	    }
		
	    _colour_loop = 1;
	}
	
	pal_run_rotation(_colours, _duration, _colour_loop, _colour_last);
}