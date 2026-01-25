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
	
	// Draw using visual_angle instead instead of image_angle to keep the hitbox static
	var _angle = animation == ANIM.MOVE || animation == ANIM.HAMMERDASH ? visual_angle : 0;
	var _alpha = state == PLAYER_STATE.DEATH ? 1 : image_alpha;
	
	draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, _angle, draw_colour, _alpha);
}