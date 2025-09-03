// Feather ignore GM2040

/// @self obj_player
function scr_player_draw()
{
	if player_type == PLAYER.TAILS
	{
	    with obj_tail
	    {
			if vd_target_player != other.id || sprite_index == -1
			{
				continue;
			}
			
			var _x = floor(other.x) + tail_offset_x * image_xscale;
		    var _y = floor(other.y) + tail_offset_y * image_yscale;	
			
		    draw_sprite_ext(sprite_index, image_index, _x, _y, image_xscale, image_yscale, image_angle, c_white, 1);
	    }
	}
	
	if state == PLAYER_STATE.DEATH
	{
		image_alpha = 1;
	}
	
	// Inherit the parent event
	event_inherited();
}