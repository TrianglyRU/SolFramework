var _x = camera_get_width(0) / 2 + 72;
var _y = camera_get_height(0) / 2 + 77;
var _icon_index = 0;

with (obj_rm_level_select)
{
	if (level_entries[global.selected_level_entry] == "SOUND TEST")
	{
		_icon_index = 1;
	}
	else switch (room_to_load)
	{
		case rm_special:
			_icon_index = 2;
		break;
		
		case rm_bonus:
			_icon_index = 3;
		break;
		
		case rm_stage_tsz0:
			_icon_index = 4;
		break;
	
		case rm_stage_tsz1:
			_icon_index = 5;
		break;
	
		case rm_stage_tsz2:
			_icon_index = 6;
		break;
	}
}

draw_sprite(spr_level_select_icon, _icon_index, _x, _y);
draw_sprite(sprite_index, 0, _x, _y);