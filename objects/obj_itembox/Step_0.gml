if state == ITEMBOX_STATE.DESTROYED
{
	return;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
    var _can_destroy = false;
	
	if solid_touch[_p] != SOLID_TYPE.TOP
	{
		if _player.m_is_true_glide() || _player.animation == ANIM.HAMMERDASH || _player.animation == ANIM.SPIN
		{
			_can_destroy = _p == 0;
		}
	}
	
	if collision_player(_player)
	{
		// Bounce up
        if _player.vel_y < 0 && _player.ext_hitbox_radius_x == 0
        {
            if floor(_player.y) >= floor(y) + 16
            {
                _player.vel_y *= -1;
                vel_y = -1.5;
                state = ITEMBOX_STATE.FALLING;
            }
        }
		
		// Destroy
        else if _can_destroy
        {
			state = ITEMBOX_STATE.DESTROYED;
			
            if !_player.is_grounded
            {
                _player.vel_y *= -1;
            }
            
			with obj_player
            {
				if on_object == other.id
				{
					on_object = noone;
					is_grounded = false;
				}
            }
			
			outside_action = OUTSIDE_ACTION.PAUSE;
			m_animation_start(spr_itembox_destroyed, 0, 2, 3);
			
            // instance_create(x, y - 3, obj_itemcard, { image_index: itembox_type });
            instance_create(x, y, obj_explosion_dust);
			audio_play_sfx(snd_destroy);
			input_set_rumble(_p, 0.05, INPUT_RUMBLE_LIGHT);	
			
            break;
        }
	}
	
    if state == ITEMBOX_STATE.IDLE && !_can_destroy
    {
		m_solid_object(_player, SOLID_TYPE.ITEM_BOX, bbox_left + 1, bbox_top + 1, bbox_right - 1, bbox_bottom - 1);
    }
}

if state == ITEMBOX_STATE.FALLING
{
    y += vel_y;
    vel_y += 0.21875;
    
    var _floor_dist = collision_tile_v(x, y + 14, 1)[0];
	
    if _floor_dist < 0
    {
        y += _floor_dist;
        state = ITEMBOX_STATE.IDLE;
    }
}