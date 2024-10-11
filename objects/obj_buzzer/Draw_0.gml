// Inherit the parent event
event_inherited();

// Draw flame
if (turn_timer <= 0)
{
	draw_sprite_ext(spr_buzzer_flame, flame_timer % 3, x, y, image_xscale, 1.0, 0.0, c_white, 1.0);
}