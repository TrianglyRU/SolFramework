// Override draw
if (sprite_index >= 0)
{
	var _player = vd_target_player;
	if (_player.super_timer <= 0 && _player.item_inv_timer == 0 && _player.state != PLAYER_STATE.DEATH)
	{
		draw_sprite_ext
		(
			sprite_index, image_index, floor(_player.x), floor(_player.y), _player.facing, image_yscale, image_angle, c_white, image_alpha
		);
	}
}