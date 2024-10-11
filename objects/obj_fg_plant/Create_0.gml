// Inherit the parent event
event_inherited();

depth = RENDERER_DEPTH_HIGHEST - 1;

switch (vd_scroll_speed)
{
	case 1/16:
		depth -= 1;
	break;
	
	case 1/8:
		depth -= 2;
	break;
	
	case 1/4:
		depth -= 3;
	break;
	
	case 1/2:
		depth -= 4;
	break;
	
	case 1:
		depth -= 5;
	break;
	
	case 2:
		depth -= 6;
	break;
}

obj_set_culling(CULLING.SUSPEND);