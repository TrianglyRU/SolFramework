with (obj_gui_save) 
{
	if (id != other.id)
	{
		instance_destroy();
	}
}

switch (global.player_main)
{
	case PLAYER.TAILS:
		sprite_index = spr_gui_save_tails;
	break;
	
	case PLAYER.KNUCKLES:
		sprite_index = spr_gui_save_knuckles;
	break;
	
	case PLAYER.AMY:
		sprite_index = spr_gui_save_amy;
	break;
}

timer = 0;
depth = RENDER_DEPTH_HUD;