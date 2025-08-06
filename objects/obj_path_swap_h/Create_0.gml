// Inherit the parent event
event_inherited();

depth = RENDERER_DEPTH_HIGHEST;
layer_data = [];

switch (image_index)
{
	case 0:
		layer_data = [TILELAYER.SECONDARY_A, TILELAYER.SECONDARY_B];
	break;
	case 1:
		layer_data = [TILELAYER.SECONDARY_B, TILELAYER.SECONDARY_A];
	break;
	case 2:
		layer_data = [TILELAYER.SECONDARY_A, TILELAYER.SECONDARY_A];
	break;
	case 3:
		layer_data = [TILELAYER.SECONDARY_B, TILELAYER.SECONDARY_B];
	break;
}

obj_set_culling(ACTIVEIF.INBOUNDS);