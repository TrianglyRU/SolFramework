// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

depth = RENDER_DEPTH_PRIORITY;
layer_data = [];

switch image_index
{
	case 0:
		layer_data = [TILE_LAYER.PATH_A, TILE_LAYER.PATH_B];
	break;
	
	case 1:
		layer_data = [TILE_LAYER.PATH_B, TILE_LAYER.PATH_A];
	break;
	
	case 2:
		layer_data = [TILE_LAYER.PATH_A, TILE_LAYER.PATH_A];
	break;
	
	case 3:
		layer_data = [TILE_LAYER.PATH_B, TILE_LAYER.PATH_B];
	break;
}