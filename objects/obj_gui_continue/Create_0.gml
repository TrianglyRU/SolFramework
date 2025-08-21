// Inherit the parent event
event_inherited();

switch (global.player_main)
{
	case PLAYER.TAILS:
		sprite_index = spr_gui_continue_tails;
	break;
	
	case PLAYER.KNUCKLES:
		sprite_index = spr_gui_continue_knuckles;
	break;
	
	case PLAYER.AMY:
		sprite_index = spr_gui_continue_amy;
	break;
}

obj_set_anim(sprite_index, 20, 0, 0);