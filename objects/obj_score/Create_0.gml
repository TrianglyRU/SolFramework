// Inherit the parent event
event_inherited();

vel_y = -3;

if (vd_score_combo < 4)
{
	image_index = vd_score_combo;
}
else
{
	image_index = vd_score_combo < 16 ? 4 : 5;
}

obj_set_priority(1);