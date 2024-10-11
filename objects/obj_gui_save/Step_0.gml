if (timer == 60)
{
	instance_destroy();
}
else
{
	sprite_animate(timer, 3);
}

timer++;