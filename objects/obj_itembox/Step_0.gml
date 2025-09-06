if state == ITEMBOX_STATE.DESTROYED
{
	return;
}

if itembox_type >= 9
{
	itembox_type = 9 + global.player_main;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
    var _can_destroy = false;
	
	if solid_touch[_p] != SOLID_TYPE.TOP
	{
		if _player.is_true_glide() || _player.animation == ANIM.HAMMERDASH || _player.animation == ANIM.SPIN
		{
			_can_destroy = _p == 0;
		}
	}
	
	if collision_player(_player, bbox_left - 1, bbox_top - 1, bbox_right + 1, bbox_bottom + 1)
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
			
			culler.action = CULL_ACTION.PAUSE;
			animator.start(spr_itembox_destroyed, 0, 2, 3);
			
            with instance_create(x, y - 3, obj_itemcard)
			{
				image_index = other.itembox_type;
			}
			
            instance_create(x, y, obj_explosion_dust);
			audio_play_sfx(snd_destroy);
			input_set_rumble(_p, 0.05, INPUT_RUMBLE_LIGHT);	
			
            break;
        }
	}
	
    if state == ITEMBOX_STATE.IDLE && !_can_destroy
    {
		solid_object(_player, SOLID_TYPE.ITEBOX);
    }
}

if state == ITEMBOX_STATE.FALLING
{
    y += vel_y;
    vel_y += 0.21875;
    
    var _floor_dist = collision_tile_v(x, bbox_bottom - 1, 1)[0];
	
    if _floor_dist < 0
    {
        y += _floor_dist;
        state = ITEMBOX_STATE.IDLE;
    }
}