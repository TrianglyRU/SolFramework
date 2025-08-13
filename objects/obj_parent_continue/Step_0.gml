if (!start_pressed)
{
	if (!input_get_pressed(0).start)
	{
		return;
	}
	
	audio_play_sfx(snd_charge_spin);
	obj_set_anim(animation_data[1], 5, 0, 0);
	start_pressed = true;
}

if (vel_charge >= vel_charge_target)
{
	x += 16;
}

vel_charge += vel_charge_acc;
if (sprite_index == animation_data[1] && !anim_frame_changed)
{
	return;
}

var _sprite = animation_data[2];
if (vel_charge >= 7 && array_length(animation_data) > 4)
{
	_sprite = animation_data[4];
}
else if (vel_charge >= 6)
{
	_sprite = animation_data[3];
}

obj_set_anim(_sprite, floor(max(1, 9 - abs(vel_charge))), 0, 0);