if iv_retract
{
    if retract_timer > 0
    {
        if --retract_timer == 0 && instance_is_drawn()
        {
            audio_play_sfx(snd_spikes_move);
        }
    }
    else
    {
        retract_offset += 8 * retract_direction;
		
        if abs(retract_offset) >= retract_distance || sign(image_xscale) != sign(retract_offset)
        {
            if image_xscale > 0
            {
                retract_offset = clamp(retract_offset, 0, retract_distance);
            }
            else if image_xscale < 0
            {
                retract_offset = clamp(retract_offset, -retract_distance, 0);
            }

            retract_timer = 60;
            retract_direction *= -1;
        }
    }

    x = xstart + retract_offset;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
    var _hurt_side = image_xscale >= 0 ? SOLID_TOUCH.LEFT : SOLID_TOUCH.RIGHT;
	
	m_solid_object(_player, SOLID_TYPE.FULL);
	
	if solid_touch[_p] == _hurt_side
	{
		_player.m_hurt(snd_spikes_hurt);
	}
}