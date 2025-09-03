// Override draw
var _x = floor(vd_target_player.x);
var _y = floor(vd_target_player.y) + vd_target_player.solid_radius_y + 1;

draw_sprite_ext
(
	sprite_index, image_index, _x, _y, vd_target_player.facing, image_yscale, image_angle, c_white, image_alpha
);