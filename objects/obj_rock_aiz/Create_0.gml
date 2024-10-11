// Inherit the parent event
event_inherited();

var _data = [0, 0];

switch (image_index)
{
	case 0:
		_data = [24, 15];
	break;
	
	case 1:
		_data = [24, 23];
	break;
	
	case 2:
		_data = [24, 39];
	break;
}

obj_set_priority(4);
obj_set_solid(_data[0], _data[1]);
obj_set_culling(CULLING.SUSPEND);