// TODO: sprite_index check shouldn't be here 
if sprite_index != -1 && player.super_timer <= 0 && player.item_inv_timer == 0 && player.state != PLAYER_STATE.DEATH
{
	draw_sprite_ext(sprite_index, image_index, floor(player.x), floor(player.y), player.facing, image_yscale, image_angle, draw_colour, image_alpha);
}