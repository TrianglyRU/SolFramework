if (state == ITEMBOXSTATE.DESTROYED)
{
	exit;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
    var _can_destroy = false;
	
	if (!obj_check_solid(_player, SOLIDCOLLISION.TOP))
    {
	    if (_player.action == ACTION.GLIDE && _player.action_state != GLIDESTATE.FALL || _player.animation == ANIM.HAMMERDASH || _player.animation == ANIM.SPIN)
	    {
	        _can_destroy = (_p == 0);
		}
	}
	
    if (obj_check_hitbox(_player, true))
    {
		// Bounce up
        if (_player.vel_y < 0 && _player.interact_radius_x_ext == 0)
        {
            if (floor(_player.y) >= floor(y + 16))
            {
                _player.vel_y *= -1;
                vel_y = -1.5;
                state = ITEMBOXSTATE.FALL;
            }
        }
		
		// Destroy
        else if (_can_destroy)
        {
			state = ITEMBOXSTATE.DESTROYED;
			
            if (!_player.is_grounded)
            {
                _player.vel_y *= -1;
            }
            	
			with (obj_player)
            {
				if (on_object == other.id)
				{
					is_grounded = false;
					on_object = noone;
				}
            }
				
			obj_set_anim(spr_itembox_destroyed, 3, 0, 2);
            obj_set_culling(CULLING.SUSPEND);
				
            instance_create(x, y - 3, obj_itemcard, { image_index: itembox_type });
            instance_create(x, y, obj_explosion_dust);
			input_set_rumble(_p, 0.05, INPUT_RUMBLE_LIGHT);
				
            break;
        }
    }
	
    if (state == ITEMBOXSTATE.IDLE && !_can_destroy)
    {
        obj_act_solid(_player, SOLIDOBJECT.ITEMBOX);
    }
}

if (state == ITEMBOXSTATE.FALL)
{
    y += vel_y;
    vel_y += 0.21875;
    
    var _floor_dist = tile_find_v(x, y + 14, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
	
    if (_floor_dist < 0)
    {
        y += _floor_dist;
        state = ITEMBOXSTATE.IDLE;
    }
}