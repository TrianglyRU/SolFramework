switch (display_timer)
{
	case 12: 
	case 28: 
	case 44:
		visible = false; 
	break;
	
	case 20: 
	case 36:
	case 52:
		visible = true; 
	break;
	
	case 60:
		instance_destroy();
	break;
}

display_timer++;