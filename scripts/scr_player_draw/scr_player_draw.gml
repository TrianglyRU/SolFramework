// Feather ignore GM2040

/// @self obj_player
function scr_player_draw()
{
	if player_type == PLAYER.TAILS
	{
	    with obj_tail
	    {
			if player != other.id || sprite_index == -1
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
	
	// Draw using visual_angle instead instead of image_angle to keep the hitbox static
	draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, animation == ANIM.MOVE || animation == ANIM.HAMMERDASH ? visual_angle : 0, draw_get_colour(), image_alpha);
}