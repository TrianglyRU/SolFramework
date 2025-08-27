if (!instance_exists(vd_target_player) || !vd_target_player.is_underwater)
{
    instance_destroy();
    return;
}

if (global.player_shields[vd_target_player.player_index] == SHIELD.BUBBLE)
{
	return;
}

if (vd_target_player.state == PLAYERSTATE.HURT || vd_target_player.state == PLAYERSTATE.DEBUG_MODE)
{
	return;
}

var _x = vd_target_player.x + 6 * vd_target_player.facing;
var _y = vd_target_player.y;
var _spawn_direction = vd_target_player.forced_roll ? DIRECTION.POSITIVE : vd_target_player.facing;
var _air_timer = vd_target_player.air_timer;

if (_air_timer > 0)
{
    if (_air_timer <= 720 && _air_timer % 120 == 0)
    {	
		if (_air_timer == 720)
		{
			countdown_bubble_frame = 0;
		}
		
        spawn_countdown_bubble = true;
    }

    if (next_bubble_timer >= 0)
    {
        next_bubble_timer--;
    }
	
    if (_air_timer % 60 == 0 || next_bubble_timer == 0)
    {
        // Schedule a follow-up bubble with a 50% chance
        if (next_bubble_timer < 0 && irandom(1) > 0)
        {
            next_bubble_timer = irandom_range(1, 16);
        }

        var _type = BUBBLE.SMALL;
		
        // Assign the countdown bubble a 25% chance to replace the main bubble
        if (spawn_countdown_bubble && (next_bubble_timer <= 0 || irandom(3) == 0))
        {
            _type = BUBBLE.COUNTDOWN;
        }
		
        instance_create(_x, _y, obj_bubble, 
        {
            vd_bubble_type: _type, vd_wobble_direction: _spawn_direction, vd_countdown_frame: countdown_bubble_frame
        });
		
        if (_type == BUBBLE.COUNTDOWN)
        {
            countdown_bubble_frame++;
            spawn_countdown_bubble = false;
        }
    }
}

// Drowning
else if (bubbles_spawned_no_air < 12)
{
    if (next_bubble_timer_no_air > 0)
    {
        next_bubble_timer_no_air--;
    }
	else
	{
		var _type = irandom(3) > 0 ? BUBBLE.SMALL : BUBBLE.MEDIUM;
		
	    instance_create(_x, _y - 12, obj_bubble,
	    {
	        vd_bubble_type: _type, vd_wobble_direction: _spawn_direction, depth: RENDER_DEPTH_PRIORITY - 1
	    });
		
	    bubbles_spawned_no_air++;
	    next_bubble_timer_no_air = irandom_range(0, 7);
	}
}