// Modify image_angle only during the draw event to keep the hitbox static
if global.rotation_mode != ROTATION.MANIA
{
	image_angle = _ceil_angle(angle);
}
else
{
	image_angle = angle;
}

// Draw self
event_inherited();

// Reset it back to normal now
image_angle = 0;