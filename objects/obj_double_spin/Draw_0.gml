// Override draw
if (sprite_index < 0)
{
	return;
}

draw_sprite_ext
(
	sprite_index, image_index, floor(vd_target_player.x), floor(vd_target_player.y), vd_target_player.facing, image_yscale, image_angle, c_white, image_alpha
);