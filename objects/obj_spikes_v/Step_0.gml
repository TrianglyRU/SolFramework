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
		
        if abs(retract_offset) >= retract_distance || sign(image_yscale) != sign(retract_offset)
        {
            if image_yscale > 0
            {
                retract_offset = clamp(retract_offset, 0, retract_distance);
            }
            else if image_yscale < 0
            {
                retract_offset = clamp(retract_offset, -retract_distance, 0);
            }
			
            retract_timer = 60;
            retract_direction *= -1;
        }
    }

    y = ystart + retract_offset;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
    var _type = _player.is_invincible() ? SOLID_TYPE.FULL : SOLID_TYPE.FULL_RESET;
    var _hurt_side = image_yscale >= 0 ? SOLID_TOUCH.TOP : SOLID_TOUCH.BOTTOM;
	
	solid_object(_player, _type);
	
	if solid_touch[_p] == _hurt_side
	{
		_player.hurt(snd_spikes_hurt);
	}
}