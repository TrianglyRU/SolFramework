enum ROCKTYPE
{
	FULL_SOLID,
	PUSHABLE,
	BREAKABLE_SIDES,
	BREAKABLE_TOP
}

// Inherit the parent event
event_inherited();

var _solid_size = [];
debris_pos_table = [];
debris_vel_table = [];
push_count = 1;

switch (image_index)
{
	case 0:
	
		_solid_size = [24, 15];
		
		debris_pos_table = 
		[
			-4,  -4,
	         12, -4,
	        -12,  4,
	         12,  4
		];
		
		debris_vel_table =
		[
			-1.0,    -2.0,
	         1.0,    -1.875,
	        -1.6875, -1.75,
	         1.75,   -1.75
		];
		
	break;
	
	case 1:
		
		_solid_size = [24, 23];
		
		debris_pos_table =
		[
			-4,  -12,
	         11, -12,
	        -4,  -4,
	        -12,  12,
	         12,  12
		];
		
		debris_vel_table =
		[
	       -2.0,    -2.0, 
	        2.0,    -2.0, 
	       -1.0,    -1.875, 
	       -1.6875, -1.75, 
	        1.75,   -1.75
		];
		
	break;
	
	case 2:
	
		_solid_size = [24, 39];
		
		debris_pos_table = 
		[
			-8, -24, 
			11, -28, 
			-4, -12, 
			12, -4, 
			-12, 4, 
			4, 12, 
			-12, 28, 
			12, 28
		];
		
		debris_vel_table = 
		[
			3.0, -3.0, 
		    2.75, -2.5, 
		    2.75, -2.5, 
		    2.5, -2.0, 
		    2.5, -1.5, 
		    2.25, -1.5, 
		    2.25, -1.0,
		    2.0, -1.0
		];
		
	break;
}

obj_set_priority(4);
obj_set_solid(_solid_size[0], _solid_size[1]);
obj_set_culling(CULLING.SUSPEND);