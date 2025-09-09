var _x = camera_get_width(view_current) * 0.5 + 72;
var _y = camera_get_height(view_current) * 0.5 + 77;
var _icon_index = 0;

if obj_rm_level_select.level_entries[global.selected_level_entry] == "SOUND TEST"
{
	_icon_index = 1;
}
else switch obj_rm_level_select.rooto_load
{
	case rm_special:
		_icon_index = 2;
	break;	
	
	case rm_bonus:
		_icon_index = 3;
	break;
	
	case rm_stage_ghz1:
		_icon_index = 4;
	break;
	
	case rm_stage_ehz1:
		_icon_index = 5;
	break;
}

draw_sprite(spr_level_select_icon, _icon_index, _x, _y);
draw_sprite(sprite_index, 0, _x, _y);